class PublishersController < ApplicationController

  def create
    offer = Trac::Offer.find(params[:offer_id])
    publisher = Trac::Publisher.find(params[:id])
    offer.publishers << publisher

    #TODO genenate track link
    render json: { message: "OK"}
  end

  private


end