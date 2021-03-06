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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120821024800) do

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "years"
    t.boolean  "official",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0
    t.integer  "ebaycat"
    t.text     "history"
  end

  create_table "coins", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "mint"
    t.integer  "year"
    t.string   "feature"
    t.integer  "mintage",     :limit => 8
    t.text     "history"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributors", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "coin_id"
    t.integer  "contributor_id",   :default => 0
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "image_remote_url"
  end

  create_table "pieces", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "coin_id"
    t.integer  "quantity",      :default => 0
    t.string   "grade"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.boolean  "approved",                          :default => false, :null => false
    t.boolean  "admin",                             :default => false, :null => false
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
