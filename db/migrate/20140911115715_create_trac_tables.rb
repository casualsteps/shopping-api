class CreateTracTables < ActiveRecord::Migration
  def change
    create_table :trac_products do |t|
      t.belongs_to :advertiser, index: true

      t.string :product_code
      t.string :product_name
      t.string :product_url
      t.string :image_url
      t.integer :price
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :trac_products, :product_code, unique: true
    add_index :trac_products, :product_name

    create_table :trac_categories_products do |t|
      t.references  :product,  index: true
      t.references  :category, index: true

      t.datetime :deleted_at

      t.timestamps
    end

    create_table :trac_categories do |t|
      t.belongs_to  :advertiser,  index: true
      t.belongs_to  :parent_category, index: true

      t.string   :category_code
      t.string   :category_name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :trac_categories, :category_code, unique: true
    add_index :trac_categories, :category_name

    create_table :trac_advertisers do |t|
      t.string :advertiser_name
      t.string :advertiser_address
      t.string :advertiser_zipcode,       limit: 9
      t.string :advertiser_telephone_no,  limit: 14
      t.string :advertiser_login_id
      t.string :advertiser_login_password
      t.string :advertiser_api_key,       limit: 32
      t.string :advertiser_url
      t.datetime :deleted_at

      t.timestamps
    end
        
    create_table  :trac_publishers  do |t|
      t.string  :publisher_name
      t.string  :publisher_address
      t.string  :publisher_zipcode,       limit: 9
      t.string  :publisher_telephone_no,  limit: 14
      t.string  :publisher_login_id
      t.string  :publisher_login_password
      t.string  :publisher_api_key,       limit: 32
      t.string  :publisher_url
      t.datetime :deleted_at

      t.timestamps
    end
    
    create_table  :trac_offers  do |t|
      t.belongs_to  :advertiser,  index: true
      t.belongs_to  :product,     index: true
      
      t.string    :offer_name
      t.string    :offer_description
      t.string    :pixel
      t.datetime  :deleted_at
      t.date      :expires_on
      
      t.timestamps
    end
    add_index :trac_offers, :offer_name

    create_table :trac_offers_publishers   do |t|
      t.belongs_to  :publisher,   index: true
      t.belongs_to  :offer,       index: true
      
      t.datetime    :deleted_at

      t.timestamps
    end

    create_table :trac_offer_tracking_links do |t|
      t.belongs_to  :offer,       index: true
      t.belongs_to  :publisher,    index: true

      t.string      :offer_url
      t.datetime    :deleted_at

      t.timestamps
    end
    
    # create_table  :trac_advertisers_offers  do |t|
    #   t.belongs_to  :advertiser,  index: true
    #   t.belongs_to  :offer,       index: true
    #
    #   t.datetime  :deleted_at
    #
    #   t.timestamps
    # end

  end
end
