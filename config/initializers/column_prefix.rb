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
end