# == Schema Information
#
# Table name: trac_offers
#
#  id                  :integer          not null, primary key
#  trac_advertisers_id :integer
#  trac_products_id    :integer
#  offer_name          :string(255)
#  offer_description   :string(255)
#  url                 :string(255)
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class Trac::Offer < ActiveRecord::Base
  belongs_to  :advertiser
  belongs_to  :product
end
