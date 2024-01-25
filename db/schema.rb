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

ActiveRecord::Schema[7.1].define(version: 2024_01_25_191717) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.text "bounding_box", default: [], array: true
    t.string "timezone"
    t.boolean "capital_city"
    t.integer "dive_centers_count", default: 0
    t.integer "dive_sites_count", default: 0
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["region_id"], name: "index_cities_on_region_id"
    t.index ["slug"], name: "index_cities_on_slug", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.text "bounding_box", default: [], array: true
    t.string "code"
    t.text "languages", default: [], array: true
    t.string "demonym"
    t.string "currency"
    t.string "pressure"
    t.string "phone_prefix"
    t.string "voltage"
    t.string "plug"
    t.string "international_airports", default: [], array: true
    t.integer "dive_centers_count", default: 0
    t.integer "dive_sites_count", default: 0
    t.integer "regions_count", default: 0
    t.integer "cities_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meta_description"
    t.string "slug"
    t.index ["slug"], name: "index_countries_on_slug", unique: true
  end

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
    t.bigint "geo_group_id"
    t.bigint "country_id"
    t.bigint "region_id"
    t.bigint "city_id"
    t.string "slug"
    t.index ["city_id"], name: "index_dive_centers_on_city_id"
    t.index ["country_id"], name: "index_dive_centers_on_country_id"
    t.index ["geo_group_id"], name: "index_dive_centers_on_geo_group_id"
    t.index ["region_id"], name: "index_dive_centers_on_region_id"
    t.index ["slug"], name: "index_dive_centers_on_slug", unique: true
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
    t.bigint "geo_group_id"
    t.bigint "country_id"
    t.bigint "region_id"
    t.bigint "city_id"
    t.string "slug"
    t.index ["city_id"], name: "index_dive_sites_on_city_id"
    t.index ["country_id"], name: "index_dive_sites_on_country_id"
    t.index ["geo_group_id"], name: "index_dive_sites_on_geo_group_id"
    t.index ["region_id"], name: "index_dive_sites_on_region_id"
    t.index ["slug"], name: "index_dive_sites_on_slug", unique: true
  end

  create_table "geo_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.text "bounding_box", default: [], array: true
    t.integer "dive_centers_count", default: 0
    t.integer "dive_sites_count", default: 0
    t.integer "countries_count", default: 0
    t.integer "regions_count", default: 0
    t.integer "cities_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.string "slug"
    t.index ["slug"], name: "index_geo_groups_on_slug", unique: true
  end

  create_table "geo_groups_countries", force: :cascade do |t|
    t.bigint "geo_group_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_geo_groups_countries_on_country_id"
    t.index ["geo_group_id"], name: "index_geo_groups_countries_on_geo_group_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.text "bounding_box", default: [], array: true
    t.integer "dive_centers_count", default: 0
    t.integer "dive_sites_count", default: 0
    t.integer "cities_count", default: 0
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["country_id"], name: "index_regions_on_country_id"
    t.index ["slug"], name: "index_regions_on_slug", unique: true
  end

  add_foreign_key "cities", "regions"
  add_foreign_key "dive_centers", "cities"
  add_foreign_key "dive_centers", "countries"
  add_foreign_key "dive_centers", "destinations"
  add_foreign_key "dive_centers", "geo_groups"
  add_foreign_key "dive_centers", "regions"
  add_foreign_key "dive_sites", "cities"
  add_foreign_key "dive_sites", "countries"
  add_foreign_key "dive_sites", "destinations"
  add_foreign_key "dive_sites", "geo_groups"
  add_foreign_key "dive_sites", "regions"
  add_foreign_key "geo_groups_countries", "countries"
  add_foreign_key "geo_groups_countries", "geo_groups"
  add_foreign_key "regions", "countries"
end
