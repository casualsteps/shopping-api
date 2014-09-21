class OffersController < ApplicationController

  private

  def query_params
    if advertiser_signed_in?
      @resource_class = Trac::Offer.joins(:offers_publishers)
      { trac_offers_publishers: { publisher_id: params[:publisher_id] } }
    elsif publisher_signed_in?
      { advertiser_id: params[:advertiser_id] }
    else
      { id: 0 }
    end
  end

  def offer_params
    params.permit *%i[offer_name offer_description preview_url landing_url product_id expires_on]
  end

end