# == Schema Information
#
# Table name: trac_advertisers_offers
#
#  id            :integer          not null, primary key
#  advertiser_id :integer
#  offer_id      :integer
#  deleted_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

class Trac::AdvertisersOffer < ActiveRecord::Base

end
