# == Schema Information
#
# Table name: trac_offers
#
#  id                :integer          not null, primary key
#  advertiser_id     :integer
#  product_id        :integer
#  offer_name        :string(255)      not null
#  offer_description :string(255)
#  pixel             :string(255)
#  preview_url       :string(255)
#  landing_url       :string(255)
#  deleted_at        :datetime
#  expires_on        :date             not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Trac::Offer < ActiveRecord::Base
  column_prefixed "offer_", only: %w[name description]

  default_scope { where(deleted_at: nil) }

  belongs_to :advertiser
  belongs_to :product
  has_many   :offer_tracking_links
  has_and_belongs_to_many :publishers
  has_many   :offers_publishers

  validates :offer_name, presence: true
  validates :expires_on, presence: true

  def self.expire
    where("expires_on <= ? AND deleted_at IS NULL", Date.today).find_each { |mortal| mortal.delete }
  end


  private

  def dependent_models
    %w[ Trac::OffersPublisher Trac::OfferTrackingLink ]
  end
end
