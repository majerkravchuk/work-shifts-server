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

ActiveRecord::Schema.define(version: 2018_07_04_205059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "business_id"
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["business_id"], name: "index_audits_on_business_id"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "time_zone", default: "Pacific Time (US & Canada)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "body"
    t.integer "status", default: 0
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
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_facilities_on_business_id"
  end

  create_table "managers_employee_positions", id: false, force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "manager_position_id"
    t.bigint "employee_position_id"
    t.index ["business_id"], name: "index_managers_employee_positions_on_business_id"
    t.index ["employee_position_id"], name: "index_managers_employee_positions_on_employee_position_id"
    t.index ["manager_position_id"], name: "index_managers_employee_positions_on_manager_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_positions_on_business_id"
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

  create_table "user_uploader_results", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_user_uploader_results_on_business_id"
    t.index ["user_id"], name: "index_user_uploader_results_on_user_id"
  end

  create_table "user_uploader_rows", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "result_id"
    t.integer "status"
    t.integer "row"
    t.string "message"
    t.index ["business_id"], name: "index_user_uploader_rows_on_business_id"
    t.index ["result_id"], name: "index_user_uploader_rows_on_result_id"
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
    t.string "invitation_token"
    t.integer "invitation_status", default: 0
    t.integer "inviter_id"
    t.string "type"
    t.boolean "super_administrator", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
