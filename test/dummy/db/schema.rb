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

ActiveRecord::Schema.define(:version => 20110412000430) do

  create_table "achievements", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "description"
    t.integer  "achievings_count", :default => 0
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "achievings", :force => true do |t|
    t.integer  "achiever_id"
    t.integer  "achievement_id"
    t.boolean  "notify",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "achiever_type"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
