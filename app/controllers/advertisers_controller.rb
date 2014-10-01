class AdvertisersController < ApplicationController
  # Returns parameter white list for #create
  def offer_params
    params.permit *%i[advertiser_name advertiser_address advertiser_zipcode advertiser_telephone_no advertiser_login_id advertiser_login_password advertiser_url]
  end

end