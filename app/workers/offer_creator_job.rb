require "uri"

class OfferCreatorJob < JobBase
  def perform(params, offer_id)
    query = URI.unescape(params.to_query "data")
    data = request(query)
    return nil if data.nil?

    # if (has_offer_id = response[:data]).nil?
    #   logger.error "Response data was empty! (request query: #{query}"
    #   return nil
    # end

    # offer = Trac::Offer.update offer_id, has_offer_id: has_offer_id
    # logger.info "New offer saved in hasOffer: " + has_offer_id unless offer.nil?
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=create&"
  end
end