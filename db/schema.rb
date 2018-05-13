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

ActiveRecord::Schema.define(version: 2018_05_13_175145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "device_uuid"
    t.string "push_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "initial_submission_status"
    t.index ["device_uuid"], name: "index_devices_on_device_uuid", unique: true
  end

  create_table "rainworks", force: :cascade do |t|
    t.string "name"
    t.string "creator_name"
    t.string "creator_email"
    t.text "description"
    t.text "image_url"
    t.integer "approval_status"
    t.boolean "active"
    t.float "lat"
    t.float "lng"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_count", default: 0, null: false
    t.integer "found_it_count", default: 0, null: false
    t.integer "faded_count", default: 0, null: false
    t.integer "missing_count", default: 0, null: false
    t.integer "inappropriate_count", default: 0, null: false
    t.datetime "installation_date"
    t.text "rejection_reason"
    t.string "thumbnail_url"
    t.boolean "show_in_gallery"
    t.index ["device_id"], name: "index_rainworks_on_device_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "rainwork_id"
    t.integer "report_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.text "description"
    t.index ["device_id"], name: "index_reports_on_device_id"
    t.index ["rainwork_id"], name: "index_reports_on_rainwork_id"
    t.index ["report_type", "device_id", "rainwork_id"], name: "index_reports_on_report_type_and_device_id_and_rainwork_id", unique: true
  end

  add_foreign_key "rainworks", "devices"
  add_foreign_key "reports", "devices"
  add_foreign_key "reports", "rainworks"
end
