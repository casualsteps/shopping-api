# == Schema Information
#
# Table name: trac_categories
#
#  id                   :integer          not null, primary key
#  advertiser_id        :integer
#  parent_category_id   :integer
#  parent_category_code :string(255)
#  category_code        :string(255)
#  category_name        :string(255)
#  deleted_at           :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

class Trac::Category < ActiveRecord::Base
  column_prefixed "category_", only: %w[code name]

  default_scope { where(deleted_at: nil) }

  belongs_to :advertiser
  belongs_to :parent_category, class_name: "Category"
  has_many :children, class_name: "Category", foreign_key: "parent_category_id"
  has_and_belongs_to_many :products

  validates :category_code, uniqueness: true
  validates :category_name, presence: true

  before_create :set_parent

  private

  def dependent_models
    %w[ Trac::CategoriesProduct ]
  end

  def set_parent
    unless parent_category_code.nil?
      parent = self.class.find_by(category_code: parent_category_code)
      self.parent_category_id = parent.id unless parent.nil?
    end
  end
end
