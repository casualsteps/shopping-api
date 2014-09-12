# == Schema Information
#
# Table name: trac_categories_products
#
#  id          :integer          not null, primary key
#  product_id  :integer
#  category_id :integer
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Trac::CategoriesProduct < ActiveRecord::Base
  belongs_to :category
  belongs_to :product

end
