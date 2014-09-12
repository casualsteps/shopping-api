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
  belongs_to :advertiser
  has_and_belongs_to_many :categories


end
