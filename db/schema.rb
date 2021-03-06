# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090906185040) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_type"
    t.integer  "layout_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "vendor_id"
    t.integer  "vat"
    t.float    "max_price",   :default => 0.0
    t.float    "min_price",   :default => 0.0
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.string  "taggable_type", :default => ""
    t.integer "taggable_id"
    t.integer "user_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name", :default => ""
    t.string "kind", :default => ""
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                            :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sex",               :default => 0
    t.date     "birthdate"
    t.string   "domain"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "name"
    t.float    "price",      :default => 0.0
    t.integer  "amount",     :default => 0
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
