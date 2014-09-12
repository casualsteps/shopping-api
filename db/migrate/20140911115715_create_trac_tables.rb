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

    create_table :trac_advertisers do |t|
      t.string :advertiser_name
      t.string :advertiser_address
      t.string :advertiser_zipcode,       limit: 9
      t.string :advertiser_telephone_no,  limit: 14
      t.string :advertiser_login_id
      t.string :advertiser_login_password
      t.string :advertiser_api_key
      t.string :advertiser_url
      t.datetime :deleted_at

      t.timestamps
    end
        
    create_table :trac_categories_products do |t|
      t.belongs_to  :trac_products, index: true
      t.belongs_to  :trac_categories
      
      t.integer :product_id,    null: false,   default: 0 
      t.integer :category_id,   null: false,   default: 0 
      t.datetime :deleted_at
      t.timestamps
    end
        
    create_table :trac_categories do |t|
      t.belongs_to  :trac_advertisers,  index: true
      t.belongs_to  :trac_categories
      
      t.string  :category_code
      t.datetime  :deleted_at
      t.timestamps  
    end
    
    create_table  :trac_publishers  do |t|
      t.string  :publisher_name
      t.string  :publisher_address
      t.string  :publisher_zipcode
      t.string  :publisher_telephone_no
      t.string  :publisher_login_id
      t.string  :publisher_login_password
      t.string  :publisher_api_key
      t.string  :publisher_url
      t.datetime  :deleted_at  
      t.timestamps
    end
    
    create_table  :trac_offers  do |t|
      t.belongs_to  :trac_advertisers,  index: true
      t.belongs_to  :trac_products,     index: true
      
      t.string    :offer_name
      t.string    :offer_description
      t.string    :url
      t.datetime  :deleted_at
      
      t.timestamps
    end
    
    add_index :trac_offers, :offer_name

    create_table :trac_offers_publisher   do |t|
      t.belongs_to  :trac_publishers,   index: true
      t.belongs_to  :trac_offers,       index: true
      
      t.datetime    :deleted_at
      t.timestamps
    end
    
    create_table  :trac_advertisers_offers  do |t|
      t.belongs_to  :trac_advertisers,  index: true
      t.belongs_to  :trac_offers,       index: true
      
      t.datetime  :deleted_at
      t.timestamps
    end

  end
end
