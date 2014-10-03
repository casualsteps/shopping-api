class OffersController < ApplicationController

  # 1) saves offer record in db & renders json response (via base class)
  # 2) calls hasOffer api asynchronously
  def create
    super
    return if @offer.nil?

    OfferCreator.perform_async params_for_rest_call, @offer.id
  end

  def update
    super
    return if @offer.nil?

    OfferModifier.perform_async params_for_rest_call, @offer.has_offer_id
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

  def params_for_rest_call
    { advertiser_id: 2, # TODO put this to environment or somewhere else
      name: params[:offer_name],
      description: params[:offer_description],
      offer_url: params[:landing_url],
      preview_url: params[:preview_url],
      expiration_date: params[:expires_on] }.compact
  end
end