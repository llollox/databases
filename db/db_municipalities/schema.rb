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

ActiveRecord::Schema.define(version: 20141022145152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caps", force: true do |t|
    t.string   "number"
    t.integer  "municipality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fractions", force: true do |t|
    t.string   "name"
    t.string   "name_encoded"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "municipality_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fractions", ["name_encoded", "region_id"], name: "index_fractions_on_name_encoded_and_region_id", using: :btree
  add_index "fractions", ["name_encoded"], name: "index_fractions_on_name_encoded", using: :btree

  create_table "municipalities", force: true do |t|
    t.integer  "province_id"
    t.integer  "region_id"
    t.string   "name"
    t.string   "name_encoded"
    t.string   "president"
    t.integer  "population"
    t.float    "density"
    t.float    "surface"
    t.string   "istat_code"
    t.string   "cadastral_code"
    t.string   "telephone_prefix"
    t.string   "email"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "province_abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipalities", ["name_encoded", "region_id"], name: "index_municipalities_on_name_encoded_and_region_id", using: :btree
  add_index "municipalities", ["name_encoded"], name: "index_municipalities_on_name_encoded", using: :btree

  create_table "municipalities_db_pictures", force: true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "picturable_id"
    t.string   "picturable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipalities_db_pictures", ["picturable_id", "picturable_type"], name: "municipalities_db_pictures_on_picturables", using: :btree

  create_table "panoramio_pictures", force: true do |t|
    t.string   "title"
    t.string   "photo_url"
    t.integer  "picturable_id"
    t.string   "picturable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "panoramio_pictures", ["picturable_id", "picturable_type"], name: "index_panoramio_pictures_on_picturable_id_and_picturable_type", using: :btree

  create_table "provinces", force: true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.string   "name_encoded"
    t.string   "president"
    t.integer  "population"
    t.float    "density"
    t.float    "surface"
    t.string   "abbreviation"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.string   "name_encoded"
    t.integer  "capital_id"
    t.string   "president"
    t.integer  "population"
    t.float    "density"
    t.float    "surface"
    t.string   "abbreviation"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["name_encoded"], name: "index_regions_on_name_encoded", using: :btree

end
