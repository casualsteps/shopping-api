class TrackingLinkGenerator < JobBase
  def perform(params, offer_id)
    data = request_has_offer(params)
    # return nil if data.nil?
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=generateTrackingLink&"
  end
end