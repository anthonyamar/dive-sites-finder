# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_25_162956) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destination_conditions", force: :cascade do |t|
    t.integer "destination_id"
    t.integer "month"
    t.float "air_temperature"
    t.float "water_temperature"
    t.float "rainfall"
    t.integer "current_strength"
    t.integer "visibility_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinations", force: :cascade do |t|
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "country_code"
    t.string "water_type"
    t.string "water_specific"
    t.string "timezone"
    t.string "languages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dive_centers_count", default: 0
    t.integer "dive_sites_count", default: 0
    t.float "latitude"
    t.float "longitude"
  end

  create_table "dive_centers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "web_url"
    t.float "longitude"
    t.float "latitude"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country_code"
    t.text "activities", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "destination_id"
  end

  create_table "dive_sites", force: :cascade do |t|
    t.string "name"
    t.string "bow"
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.string "region"
    t.string "country"
    t.boolean "is_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "destination_id"
  end

  add_foreign_key "dive_centers", "destinations"
  add_foreign_key "dive_sites", "destinations"
end
