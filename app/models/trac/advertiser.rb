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
#  advertiser_api_key        :string(32)
#  advertiser_url            :string(255)
#  deleted_at                :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

class Trac::Advertiser < ActiveRecord::Base
  column_prefixed "advertiser_"

  include TokenGeneratable

  has_many :categories
  has_many :products
  has_many :offers

  scope :valid, ->{ where(deleted_at: nil) }


  private

  def dependent_models
    %w[ Trac::Offer Trac::Product Trac::Category ]
  end
end
