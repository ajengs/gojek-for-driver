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

ActiveRecord::Schema.define(version: 20171218071611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.bigint "external_id"
    t.string "origin"
    t.string "destination"
    t.string "origin_coordinates"
    t.string "destination_coordinates"
    t.float "price"
    t.bigint "user_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "payment_type"
    t.index ["type_id"], name: "index_orders_on_type_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.float "gopay", default: 0.0, null: false
    t.string "license_plate"
    t.float "rating", default: 5.0, null: false
    t.string "current_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["latitude", "longitude"], name: "index_users_on_latitude_and_longitude"
    t.index ["type_id"], name: "index_users_on_type_id"
  end

  add_foreign_key "users", "types"
end
