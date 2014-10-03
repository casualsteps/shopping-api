require "uri"

class OfferCreator < JobBase
  def perform(params, offer_id)
    response = request_has_offer(params)
    return nil if response.nil?

    if response[:data].blank? || (data = response[:data][:Offer]).nil?
      logger.error "Response data was empty!"
      return nil
    end

    offer = Trac::Offer.update(offer_id, has_offer_id: data[:id])
    logger.info "New offer saved in hasOffer. hasOffer ID: #{offer.has_offer_id}" unless offer.nil?
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=create&"
  end
end