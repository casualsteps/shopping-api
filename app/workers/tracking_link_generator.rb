class TrackingLinkGenerator < JobBase
  def perform(params, offer_id, publisher_id)
    response = request_has_offer(nil, params)
    return nil if response.nil?

    if (data = response[:data]).nil?
      logger.error "Response data was empty!"
      return nil
    end

    link = Trac::OfferTrackingLink.create!(offer_id: offer_id,
                                           publisher_id: publisher_id,
                                           tracking_link: data[:click_url])
    logger.info "New tracking link was saved: #{link.tracking_link}"
  end

  private

  def base_url
    "http://api.hasoffers.com/v3/Offer.json?Method=generateTrackingLink&"
  end
end