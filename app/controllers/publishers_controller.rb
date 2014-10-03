class PublishersController < ApplicationController

  def update
    offer = Trac::Offer.find(params[:offer_id])
    publisher = Trac::Publisher.find(params[:id])

    authorize publisher

    offer.publishers << publisher

    render json: { message: "OK" }

    params = {
      offer_id: offer.has_offer_id,
      affiliate_id: 8 # TODO need to be changed according to publisher
    }

    TrackingLinkGenerator.perform_async(params, offer.id, publisher.id)
  end

  private


end