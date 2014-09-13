# == Schema Information
#
# Table name: trac_categories
#
#  id                 :integer          not null, primary key
#  advertiser_id      :integer
#  parent_category_id :integer
#  category_code      :string(255)
#  category_name      :string(255)
#  deleted_at         :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Trac::Category < ActiveRecord::Base
  column_prefixed "category_", only: %w[code name]

  belongs_to :advertiser
  belongs_to :parent_category, class_name: "Category"
  has_many :children, class_name: "Category", foreign_key: "parent_category_id"
  has_and_belongs_to_many :products

  scope :valid, ->{ where(deleted_at: nil) }


  private

  def related_models
    %w[ Trac::CategoriesProduct ]
  end
end
