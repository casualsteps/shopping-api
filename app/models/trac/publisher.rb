# == Schema Information
#
# Table name: trac_publishers
#
#  id                       :integer          not null, primary key
#  publisher_name           :string(255)
#  publisher_address        :string(255)
#  publisher_zipcode        :string(9)
#  publisher_telephone_no   :string(14)
#  publisher_login_id       :string(255)
#  publisher_login_password :string(255)
#  publisher_api_key        :string(32)
#  publisher_url            :string(255)
#  deleted_at               :datetime
#  created_at               :datetime
#  updated_at               :datetime
#

class Trac::Publisher < ActiveRecord::Base
  column_prefixed "publisher_"

  include TokenGeneratable

  has_many :offer_tracking_links
  has_and_belongs_to_many :offers

  scope :valid, ->{ where(deleted_at: nil) }


  private

  def dependent_models
    %w[ Trac::OffersPublisher Trac::OfferTrackingLink ]
  end
end
