class CreateTracTables < ActiveRecord::Migration
  def change
    create_table :trac_products do |t|
      t.belongs_to :advertiser
      t.string :product_code
      t.string :product_name
      t.string :product_url
      t.string :image_url
      t.integer :price
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end

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
  end
end
