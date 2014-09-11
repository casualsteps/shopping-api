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

require 'test_helper'

class Trac::ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
