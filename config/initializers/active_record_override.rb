class ActiveRecord::Base
  def self.column_prefixed(prefix, except: [], only: [])
    skipped_columns = %w[id created_at updated_at deleted_at] + except
    columns.each do |column|
      column_name = column.name
      unless skipped_columns.include?(column_name)
        unprefixed_col = (column_name.scan /^#{prefix}(.*)/).flatten.first
        next if only.present? && !only.include?(unprefixed_col)

        define_method "#{unprefixed_col}" do
          self.send "#{column_name}"
        end

        define_method "#{unprefixed_col}=" do |value|
          self.send "#{column_name}=", value
        end
      end
    end
  end


  def delete
    return self unless deleted_at.nil?

    now = Time.now
    transaction do
      update! deleted_at: now
      dependent_models.each do |class_name|
        # eg. if self = Category & class_name = Trac::CategoriesProduct ==> Trac::CategoriesProduct.where(category_id: id)...
        class_name.constantize.where("#{self.class.to_s.demodulize.downcase}_id".to_sym => id).update_all(deleted_at: now)
      end if defined? dependent_models
    end
    self
  end

  def deleted?
    !deleted_at.nil?
  end

  def revive
    return self if deleted_at.nil?

    transaction do
      update! deleted_at: nil
      dependent_models.each do |class_name|
        # eg. if self = Category and class_name = Trac::CategoriesProduct, Trac::CategoriesProduct.where(category_id: id)...
        # REVIEW is it ok to revive all the relations?
        class_name.constantize.where("#{self.class.to_s.demodulize.downcase}_id".to_sym => id).update_all(deleted_at: nil)
      end if defined? dependent_models
    end
    self
  end
end