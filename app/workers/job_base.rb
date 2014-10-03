require "rest_client"

class JobBase
  include Sidekiq::Worker
  sidekiq_options retry: false

  def self.perform_now(*args)
    new.perform(*args)
  end

  protected

  def request_has_offer(data_params, additional_params = nil)
    query = data_params.blank? ? "" : URI.unescape(data_params.to_query "data")
    unless additional_params.nil?
      query << "&" unless query.blank?
      query << additional_params.to_query(nil)
    end
    request_url = base_url + "NetworkToken=#{network_token}&NetworkId=#{network_id}&#{query}&return_object=true"

    logger.info "Calling... #{request_url}"

    response = request_get(request_url)
    logger.info "Response: #{response.body}"
    process_response(response)
  end

  def network_token
    # TODO use environment variable
    "NETkUaGcw2LrJF9sB8bIlAZvyPWyoE"
  end

  def network_id
    "casualsteps"
  end

  def base_url
    ""
  end

  private

  def request_get(request_url)
    return get_without_timeout(request_url, accept: :json)
  rescue Exception => e
    logger.error "Rest request failed.. Code: #{defined?(e.http_code) && e.http_code ? e.http_code : "Unknown"}, Requested URL: #{request_url} => #{e.message}"
    if defined?(e.response) && e.response
      data = JSON.parse(e.response.body, symbolize_names: true)
      log_response(response) if (response = data[:response]) && response[:errors]
    end
    return nil
  end

  def process_response(response)
    if response.nil?
      logger.error "Nothing returned from the server!"
      return nil
    end

    data = JSON.parse(response.body, symbolize_names: true)
    if data.nil? || (response_part = data[:response]).nil?
      logger.error "Empty response returned from the server!"
      return nil
    end
    if response_part[:httpStatus] != 200 || response_part[:status] == -1
      log_response response_part
      return nil
    end

    data[:response]
  end

  def log_response(response)
    logger.error response[:errors].map { |error| error[:publicMessage] }.join("\n")
  end

  # send GET request without timeout.. (Calling hasOffer api takes at least 60 secs.)
  def get_without_timeout(url, headers={}, &block)
    RestClient::Request.new(method: :get, url: url, headers: headers, timeout: nil).execute(& block)
  end

end