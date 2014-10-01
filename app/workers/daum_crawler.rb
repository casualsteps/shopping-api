class DaumCrawler < JobBase
  include Sidetiq::Schedulable

  recurrence { daily }

  LEAVE_LOG = false
  REQUEST_URL = "http://apis.daum.net/shopping/search?apikey=4b9c4ad51233a485297fd3a76dfe620a892c8155&"

  def perform
    Trac::Category.find_each do |category|
      next if category.parent_category_id.nil?
      dad = category.parent_category
      next if dad.parent_category_id.nil?
      grandpa = category.parent_category.parent_category

      query = "#{grandpa.name} #{dad.name} #{category.name}"
      log query
      50.times do |i|
        request [grandpa, dad, category], q: query, result: 20, pageno: i+1, sort: "date", output: "json"
      end
    end
  end

  private

  def request(categories, params)
    response = request_get(REQUEST_URL + params.to_query)
    log response
    process_response(categories, response)
  end

  def process_response(categories, response)
    if response.nil?
      logger.error "Nothing returned from the server!"
      return nil
    end

    data = JSON.parse(response.body, symbolize_names: true)
    if data.nil?
      logger.error "Empty response returned from the server!"
      return nil
    end

    data[:channel][:item].each do |item|
      maker = Trac::Advertiser.find_or_create_by(advertiser_name: item[:maker])
      product = Trac::Product.find_or_initialize_by(product_code: item[:docid]) do |p|
        p.product_name = item[:title]
        p.product_url = item[:link]
        p.advertiser_id = maker.id
        p.price = item[:price_min]
        p.image_url = item[:image_url]
        p.created_at = Date.parse(item[:publish_date])
      end
      if product.new_record?
        product.save
        categories.each { |c| product.categories << c }
        puts "'#{product.name}' saved."
      end
    end
  end

  def log(string)
    puts string if LEAVE_LOG
  end
end