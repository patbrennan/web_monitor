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

ActiveRecord::Schema.define(version: 20180320145435) do

  create_table "alerts", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.string "current_status"
    t.string "notify_emails"
    t.integer "crawl_interval_mins"
    t.integer "response_time_threshold_ms"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_crawl"
  end

  create_table "crawls", force: :cascade do |t|
    t.integer "alert_id"
    t.datetime "crawl_time"
    t.string "resp_code"
    t.string "resp_status"
    t.integer "resp_time_ms"
    t.integer "resp_size_kb"
  end

  create_table "user_alerts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "alert_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "time_zone"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.boolean "email_confirmed"
    t.string "pw_reset_token"
    t.datetime "pw_reset_time"
  end

end
