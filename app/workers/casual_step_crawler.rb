class CasualStepCrawler < JobBase
  LEAVE_LOG = false

  def perform
    request_url = "https://gosnapshop.com/ep/all.txt"
    data = get_without_timeout(request_url)
    process_response(data)
  end

  private

  def process_response(data)
    new_product = nil
    category = []
    # index = 0

    data.to_s.each_line do |line|
      case
        when start_with_tag?(line, "begin")
          new_product = Trac::Product.new
          log "begin!"
        when start_with_tag?(line, "pname")
          new_product.name = content_for(line, "pname")
          log "pname: #{new_product.product_name}"
        when start_with_tag?(line, "price")
          new_product.price = content_for(line, "price").to_i
          log "price: #{new_product.price}"
        when start_with_tag?(line, "pgurl")
          new_product.url = content_for(line, "pgurl")
          log "url: #{new_product.product_url}"
        when start_with_tag?(line, "igurl")
          new_product.image_url = content_for(line, "igurl")
          log "image_url: #{new_product.image_url}"
        when start_with_tag?(line, "cate1")
          category[0] = Trac::Category.new(category_name: content_for(line, "cate1"))
          log "category 1: #{category[0].category_name}"
        when start_with_tag?(line, "cate2")
          category[1] = Trac::Category.new(category_name: content_for(line, "cate2"))
          log "category 2: #{category[1].category_name}"
        when start_with_tag?(line, "cate3")
          category[2] = Trac::Category.new(category_name: content_for(line, "cate3"))
          log "category 3: #{category[2].category_name}"
        when start_with_tag?(line, "cate4") && content_for(line, "cate4").present?
          category[3] = Trac::Category.new(category_name: content_for(line, "cate4"))
          log "category 4: #{category[3].category_name}"
        when start_with_tag?(line, "caid1")
          existing_category = Trac::Category.find_by(category_code: content_for(line, "caid1"))
          if existing_category
            new_product.categories << existing_category
            category[0] = existing_category
          else
            category[0].update! category_code: content_for(line, "caid1")
            puts "category 1 [#{category[0].category_name}] saved."
            new_product.categories << category[0]
          end
        when start_with_tag?(line, "caid2")
          existing_category = Trac::Category.find_by(category_code: content_for(line, "caid2"))
          if existing_category
            new_product.categories << existing_category
            category[1] = existing_category
          else
            category[1].update! category_code: content_for(line, "caid2"), parent_category_id: category[0].id, parent_category_code: category[0].code
            new_product.categories << category[1]
            puts "category 2 [#{category[1].category_name}] saved."
          end
        when start_with_tag?(line, "caid3")
          existing_category = Trac::Category.find_by(category_code: content_for(line, "caid3"))
          if existing_category
            new_product.categories << existing_category
            category[2] = existing_category
          else
            category[2].update! category_code: content_for(line, "caid3"), parent_category_id: category[1].id, parent_category_code: category[1].code
            new_product.categories << category[2]
            puts "category 3 [#{category[2].category_name}] saved."
          end
        when start_with_tag?(line, "caid4")
          existing_category = Trac::Category.find_by(category_code: content_for(line, "caid4"))
          if existing_category
            new_product.categories << existing_category
            category[3] = existing_category
          else
            category[3].update! category_code: content_for(line, "caid4"), parent_category_id: category[2].id, parent_category_code: category[2].code
            new_product.categories << category[3]
            puts "category 4 [#{category[3].category_name}] saved."
          end
        when start_with_tag?(line, "deliv")
          # ???
        when start_with_tag?(line, "ftend")
          new_product.save!
          puts "'#{new_product.name}' saved!"
          new_product = nil
          # index += 1
          # break if index > 2
        else
          # puts line
      end
    end
  end

  def start_with_tag?(line, tag_name)
    line.start_with?(tag_for tag_name) && content_for(line, "caid4").present?
  end

  def tag_for(element)
    "<<<#{element}>>>"
  end

  def content_for(string, tag_name)
    string.gsub(tag_for(tag_name), "").chomp
  end

  def log(string)
    puts string if LEAVE_LOG
  end
end