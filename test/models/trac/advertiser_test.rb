# == Schema Information
#
# Table name: trac_advertisers
#
#  id                        :integer          not null, primary key
#  advertiser_name           :string(255)
#  advertiser_address        :string(255)
#  advertiser_zipcode        :string(9)
#  advertiser_telephone_no   :string(14)
#  advertiser_login_id       :string(255)
#  advertiser_login_password :string(255)
#  advertiser_api_key        :string(255)
#  advertiser_url            :string(255)
#  deleted_at                :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

require 'test_helper'

class Trac::AdvertiserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
