# == Schema Information
#
# Table name: trac_offer_tracking_links
#
#  id            :integer          not null, primary key
#  offer_id      :integer
#  publisher_id  :integer
#  tracking_link :string(255)
#  deleted_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

class Trac::OfferTrackingLink < ActiveRecord::Base
  belongs_to :offer
  belongs_to :publisher

  scope :valid, ->{ where(deleted_at: nil) }

end
