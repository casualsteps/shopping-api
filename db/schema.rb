# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140911115715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trac_advertisers", force: true do |t|
    t.string   "advertiser_name"
    t.string   "advertiser_address"
    t.string   "advertiser_zipcode",        limit: 9
    t.string   "advertiser_telephone_no",   limit: 14
    t.string   "advertiser_login_id"
    t.string   "advertiser_login_password"
    t.string   "advertiser_api_key"
    t.string   "advertiser_url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trac_advertisers_offers", force: true do |t|
    t.integer  "advertiser_id"
    t.integer  "offer_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_advertisers_offers", ["advertiser_id"], name: "index_trac_advertisers_offers_on_advertiser_id", using: :btree
  add_index "trac_advertisers_offers", ["offer_id"], name: "index_trac_advertisers_offers_on_offer_id", using: :btree

  create_table "trac_categories", force: true do |t|
    t.integer  "advertiser_id"
    t.integer  "parent_category_id"
    t.string   "category_code"
    t.string   "category_name"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_categories", ["advertiser_id"], name: "index_trac_categories_on_advertiser_id", using: :btree
  add_index "trac_categories", ["category_code"], name: "index_trac_categories_on_category_code", unique: true, using: :btree
  add_index "trac_categories", ["category_name"], name: "index_trac_categories_on_category_name", using: :btree
  add_index "trac_categories", ["parent_category_id"], name: "index_trac_categories_on_parent_category_id", using: :btree

  create_table "trac_categories_products", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_categories_products", ["category_id"], name: "index_trac_categories_products_on_category_id", using: :btree
  add_index "trac_categories_products", ["product_id"], name: "index_trac_categories_products_on_product_id", using: :btree

  create_table "trac_offers", force: true do |t|
    t.integer  "advertiser_id"
    t.integer  "product_id"
    t.string   "offer_name"
    t.string   "offer_description"
    t.string   "url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_offers", ["advertiser_id"], name: "index_trac_offers_on_advertiser_id", using: :btree
  add_index "trac_offers", ["offer_name"], name: "index_trac_offers_on_offer_name", using: :btree
  add_index "trac_offers", ["product_id"], name: "index_trac_offers_on_product_id", using: :btree

  create_table "trac_offers_publishers", force: true do |t|
    t.integer  "publisher_id"
    t.integer  "offer_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_offers_publishers", ["offer_id"], name: "index_trac_offers_publishers_on_offer_id", using: :btree
  add_index "trac_offers_publishers", ["publisher_id"], name: "index_trac_offers_publishers_on_publisher_id", using: :btree

  create_table "trac_products", force: true do |t|
    t.integer  "advertiser_id"
    t.string   "product_code"
    t.string   "product_name"
    t.string   "product_url"
    t.string   "image_url"
    t.integer  "price"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trac_products", ["advertiser_id"], name: "index_trac_products_on_advertiser_id", using: :btree
  add_index "trac_products", ["product_code"], name: "index_trac_products_on_product_code", unique: true, using: :btree
  add_index "trac_products", ["product_name"], name: "index_trac_products_on_product_name", using: :btree

  create_table "trac_publishers", force: true do |t|
    t.string   "publisher_name"
    t.string   "publisher_address"
    t.string   "publisher_zipcode",        limit: 9
    t.string   "publisher_telephone_no",   limit: 14
    t.string   "publisher_login_id"
    t.string   "publisher_login_password"
    t.string   "publisher_api_key"
    t.string   "publisher_url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
