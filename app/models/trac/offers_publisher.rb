# == Schema Information
#
# Table name: trac_offers_publishers
#
#  id           :integer          not null, primary key
#  publisher_id :integer
#  offer_id     :integer
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Trac::OffersPublisher < ActiveRecord::Base
  belongs_to :offer
  belongs_to :publisher

end
