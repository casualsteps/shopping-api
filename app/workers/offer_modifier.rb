require "uri"

class OfferModifier < JobBase
  def perform(params)
    data = request_has_offer(params, { id: params.delete(:id) })
    # return nil if data.nil?
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=update&"
  end
end