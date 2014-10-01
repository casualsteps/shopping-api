class PublishersController < ApplicationController

  def create
    offer = Trac::Offer.find(params[:offer_id])
    publisher = Trac::Publisher.find(params[:id])
    offer.publishers << publisher

    render json: { message: "OK" }

    TrackingLinkGenerator.perform_async({offer_id: offer.id})
  end

  private


end