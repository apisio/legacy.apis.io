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

ActiveRecord::Schema.define(:version => 20120317233334) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "contact_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "follow_id"
    t.integer  "register_id"
    t.string   "message"
  end

  create_table "apis", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "apiurl"
    t.string   "imageurl"
    t.text     "description"
    t.string   "category"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "apidocurl"
  end

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "block_id"
  end

  create_table "parameters", :force => true do |t|
    t.integer  "resource_id"
    t.string   "paramtype"
    t.string   "paramname"
    t.string   "paramvalue"
    t.boolean  "paramrequired"
    t.string   "paramdocurl"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "paramstyle"
    t.string   "paramdefault"
    t.text     "description"
    t.text     "payload"
    t.integer  "app_id"
  end

  create_table "resources", :force => true do |t|
    t.integer  "api_id"
    t.string   "resourcename"
    t.string   "pathurl"
    t.string   "resourcemethod"
    t.string   "authentication"
    t.string   "curlexample"
    t.string   "docurl"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "statuses", :force => true do |t|
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "admin"
    t.string   "provider"
    t.string   "uid"
    t.string   "photo"
    t.boolean  "allowemail"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "blog"
    t.text     "about_me"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "fbtoken"
    t.string   "fbid"
    t.boolean  "trustee"
  end

end
