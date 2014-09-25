class OffersController < ApplicationController

  # 1) saves offer record in db & renders json response (via base class)
  # 2) calls hasOffer api asynchronously
  def create
    super
    return if @offer.nil?

    rest_params = params.extract!(*%i[offer_name offer_description preview_url expires_on])
    rest_params[:name] = rest_params.delete(:offer_name)
    rest_params[:description] = rest_params.delete(:offer_description)
    rest_params[:expiration_date] = rest_params.delete(:expires_on)

    OfferCreatorJob.perform_async rest_params
  end

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

  # Returns parameter white list for #create
  def offer_params
    params[:advertiser_id] = current_advertiser.id
    params.permit *%i[advertiser_id offer_name offer_description preview_url landing_url product_id expires_on]
  end
end