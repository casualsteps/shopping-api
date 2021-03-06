# == Schema Information
#
# Table name: trac_products
#
#  id            :integer          not null, primary key
#  advertiser_id :integer
#  product_code  :string(255)
#  product_name  :string(255)
#  product_url   :string(255)
#  image_url     :string(255)
#  price         :integer
#  slug          :string(255)
#  deleted_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

class Trac::Product < ActiveRecord::Base
  column_prefixed "product_", only: %w[code name url]

  default_scope { where(deleted_at: nil) }

  belongs_to :advertiser
  has_many :offers
  has_and_belongs_to_many :categories

  validates :product_code, uniqueness: true, allow_nil: true
  # validates :advertiser_id, presence: true


  private

  def dependent_models
    %w[ Trac::CategoriesProduct Trac::Offer ]
  end
end
