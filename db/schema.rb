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

ActiveRecord::Schema.define(version: 2018_06_07_183614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees_facilities", id: false, force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "employee_id"
    t.bigint "facility_id"
    t.index ["business_id"], name: "index_employees_facilities_on_business_id"
    t.index ["employee_id"], name: "index_employees_facilities_on_employee_id"
    t.index ["facility_id"], name: "index_employees_facilities_on_facility_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.integer "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers_employees_positions", id: false, force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "manager_position_id"
    t.bigint "employee_position_id"
    t.index ["business_id"], name: "index_managers_employees_positions_on_business_id"
    t.index ["employee_position_id"], name: "index_managers_employees_positions_on_employee_position_id"
    t.index ["manager_position_id"], name: "index_managers_employees_positions_on_manager_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "role", default: 0
    t.integer "position_id"
    t.integer "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "business_id"], name: "index_users_on_email_and_business_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
