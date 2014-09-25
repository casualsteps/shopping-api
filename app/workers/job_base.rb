require "rest_client"

class JobBase
  include Sidekiq::Worker
  sidekiq_options retry: false

  def self.perform_now(*args)
    new.perform(*args)
  end

  protected

  def request(params)
    query = URI.unescape(params.to_query "data")
    request_url = base_url + "NetworkToken=#{network_token}&NetworkId=#{network_id}&#{query}"
    logger.info "Calling... #{request_url}"

    begin
      result = get(request_url, accept: :json)
    rescue Exception => e
      logger.error "Rest request failed.. Code: #{defined?(e.http_code) && e.http_code ? e.http_code : "Unknown"}, Requested URL: #{request_url} => #{e.message}"
      if defined?(e.response) && e.response
        data = JSON.parse(e.response.body, symbolize_names: true)
        log_response(response) if (response = data[:response]) && response[:errors]
      end
      return nil
    end

    if result.nil?
      logger.error "Nothing returned from the server!"
      return nil
    end

    data = JSON.parse(result.body, symbolize_names: true)
    if data.nil? || (response = data[:response]).nil?
      logger.error "Empty response returned from the server!"
      return nil
    end
    if response[:httpStatus] != 200 || response[:status] == -1
      log_response response
      return nil
    end

    data
  end

  def log_response(response)
    logger.error response[:errors].map { |error| error[:publicMessage] }.join("\n")
  end

  def network_token
    # TODO use environment variable
    "NETkUaGcw2LrJF9sB8bIlAZvyPWyoE"
  end

  def network_id
    ""
  end

  def base_url
    ""
  end

  private

  # send GET request without timeout.. (Calling hasOffer api takes at least 60 secs.)
  def get(url, headers={}, &block)
    RestClient::Request.new(method: :get, url: url, headers: headers, timeout: nil).execute(& block)
  end
end