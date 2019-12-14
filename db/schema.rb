# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_01_030150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_logs", force: :cascade do |t|
    t.bigint "door_id", null: false
    t.bigint "code_id"
    t.boolean "success", null: false
    t.string "denied_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code_id"], name: "index_access_logs_on_code_id"
    t.index ["door_id"], name: "index_access_logs_on_door_id"
  end

  create_table "codes", force: :cascade do |t|
    t.string "value", null: false
    t.string "name", null: false
    t.string "allowed_time"
    t.datetime "disabled_at"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id", "value"], name: "index_codes_on_organization_id_and_value", unique: true
    t.index ["organization_id"], name: "index_codes_on_organization_id"
  end

  create_table "doors", force: :cascade do |t|
    t.string "name", null: false
    t.string "timezone", null: false
    t.string "phone_number", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_doors_on_organization_id"
    t.index ["phone_number"], name: "index_doors_on_phone_number", unique: true
  end

  create_table "doors_codes", force: :cascade do |t|
    t.bigint "door_id", null: false
    t.bigint "code_id", null: false
    t.index ["code_id"], name: "index_doors_codes_on_code_id"
    t.index ["door_id", "code_id"], name: "index_doors_codes_on_door_id_and_code_id", unique: true
    t.index ["door_id"], name: "index_doors_codes_on_door_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "image", null: false
    t.string "email", null: false
    t.bigint "organization_id"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "access_logs", "codes"
  add_foreign_key "access_logs", "doors"
  add_foreign_key "codes", "organizations"
  add_foreign_key "doors", "organizations"
  add_foreign_key "doors_codes", "codes"
  add_foreign_key "doors_codes", "doors"
  add_foreign_key "users", "organizations"
end
