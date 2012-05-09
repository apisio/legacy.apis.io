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

ActiveRecord::Schema.define(:version => 20120509164814) do

  create_table "apis", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "apiurl"
    t.string   "imageurl"
    t.text     "description"
    t.string   "category"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "apidocurl"
    t.boolean  "privateaccess"
    t.string   "provider"
  end

  create_table "explorers", :force => true do |t|
    t.integer  "user_id"
    t.text     "apirequest"
    t.text     "apiresponse"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "reference"
    t.boolean  "privateaccess"
    t.string   "provider"
  end

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "block_id"
  end

  create_table "mashups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "api_id"
    t.string   "mashupname"
    t.string   "mashupurl"
    t.string   "mashupimageurl"
    t.text     "mashupdesc"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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
    t.integer  "api_id"
  end

  create_table "resources", :force => true do |t|
    t.integer  "api_id"
    t.string   "resourcename"
    t.string   "pathurl"
    t.string   "resourcemethod"
    t.string   "authentication"
    t.text     "curlexample"
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
    t.integer  "api_id"
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
