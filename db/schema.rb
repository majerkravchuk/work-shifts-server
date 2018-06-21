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

ActiveRecord::Schema.define(version: 2018_06_16_213905) do

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

  create_table "facilities_invitation", id: false, force: :cascade do |t|
    t.bigint "facility_id"
    t.bigint "invitation_id"
    t.index ["facility_id"], name: "index_facilities_invitation_on_facility_id"
    t.index ["invitation_id"], name: "index_facilities_invitation_on_invitation_id"
  end

  create_table "invitation_loading_results", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "manager_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_invitation_loading_results_on_business_id"
    t.index ["manager_id"], name: "index_invitation_loading_results_on_manager_id"
  end

  create_table "invitation_loading_rows", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "result_id"
    t.integer "status"
    t.integer "row"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_invitation_loading_rows_on_business_id"
    t.index ["result_id"], name: "index_invitation_loading_rows_on_result_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "position_id"
    t.bigint "manager_id"
    t.string "name"
    t.string "email"
    t.string "token"
    t.integer "role", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_invitations_on_business_id"
    t.index ["email"], name: "index_invitations_on_email"
    t.index ["manager_id"], name: "index_invitations_on_manager_id"
    t.index ["position_id"], name: "index_invitations_on_position_id"
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

  create_table "shifts", force: :cascade do |t|
    t.string "name"
    t.bigint "business_id"
    t.bigint "facility_id"
    t.bigint "employee_position_id"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_shifts_on_business_id"
    t.index ["employee_position_id"], name: "index_shifts_on_employee_position_id"
    t.index ["facility_id"], name: "index_shifts_on_facility_id"
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
    t.string "name", null: false
    t.integer "role", default: 0
    t.integer "position_id"
    t.integer "business_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "business_id"], name: "index_users_on_email_and_business_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
