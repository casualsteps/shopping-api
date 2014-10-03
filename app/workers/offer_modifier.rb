require "uri"

class OfferModifier < JobBase
  def perform(params, has_offer_id)
    data = request_has_offer(params, id: has_offer_id)
    # return nil if data.nil?
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=update&"
  end
end