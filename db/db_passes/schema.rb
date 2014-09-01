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

ActiveRecord::Schema.define(version: 20140728203902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "localities", force: true do |t|
    t.integer  "pass_id"
    t.integer  "localitiable_id"
    t.string   "localitiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localities", ["localitiable_id", "localitiable_type"], name: "index_localities_on_localitiable_id_and_localitiable_type", using: :btree

  create_table "passes", force: true do |t|
    t.string   "name"
    t.string   "locality"
    t.integer  "altitude"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name_encoded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passes", ["name_encoded"], name: "index_passes_on_name_encoded", using: :btree

end
