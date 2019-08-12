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

ActiveRecord::Schema.define(version: 2019_07_25_132853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "namespace", limit: 255
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "file", limit: 255
    t.integer "attachable_id"
    t.string "attachable_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_id"], name: "index_attachments_on_attachable_id"
  end

  create_table "certificate_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "number_employees"
    t.string "industry", limit: 255
    t.string "website", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_language", limit: 255
    t.boolean "excluded_from_search", default: false
    t.integer "import_id"
    t.text "comment"
  end

  create_table "company_addresses", force: :cascade do |t|
    t.bigint "company_id"
    t.string "street"
    t.string "zip"
    t.string "city"
    t.string "country"
    t.string "phone"
    t.string "fax"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_addresses_on_company_id"
  end

  create_table "complete_internships", force: :cascade do |t|
    t.bigint "semester_id"
    t.integer "semester_of_study"
    t.boolean "aep"
    t.boolean "passed"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_complete_internships_on_semester_id"
    t.index ["student_id"], name: "index_complete_internships_on_student_id"
  end

  create_table "contract_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "downloads", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_processors", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_compares", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "internship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "comparebox"
  end

  create_table "financings", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internship_offers", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "body"
    t.string "pdf", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "country"
    t.boolean "active"
  end

  create_table "internship_ratings", id: :serial, force: :cascade do |t|
    t.integer "tasks", limit: 2
    t.integer "training_success", limit: 2
    t.integer "atmosphere", limit: 2
    t.integer "supervision", limit: 2
    t.integer "appreciation", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internship_searches", id: :serial, force: :cascade do |t|
    t.string "country", limit: 255
    t.string "city", limit: 255
    t.string "industry", limit: 255
    t.string "orientation", limit: 255
    t.integer "min_salary"
    t.integer "max_salary"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internship_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internships", id: :serial, force: :cascade do |t|
    t.float "working_hours"
    t.float "living_costs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "internship_rating_id", default: 1
    t.integer "x_company_id"
    t.integer "user_id"
    t.string "title", limit: 255
    t.boolean "recommend", default: true
    t.integer "orientation_id"
    t.boolean "email_public"
    t.text "description"
    t.integer "semester_id"
    t.string "internship_report", limit: 255
    t.integer "salary"
    t.date "start_date"
    t.date "end_date"
    t.text "tasks"
    t.string "operational_area", limit: 255
    t.integer "internship_state_id"
    t.integer "reading_prof_id"
    t.integer "payment_state_id"
    t.integer "registration_state_id"
    t.integer "contract_state_id"
    t.integer "report_state_id", default: 1
    t.integer "certificate_state_id"
    t.date "certificate_signed_by_internship_officer"
    t.date "certificate_signed_by_prof"
    t.date "certificate_to_prof"
    t.text "comment"
    t.string "supervisor_email", limit: 255
    t.string "supervisor_name", limit: 255
    t.boolean "completed", default: false
    t.bigint "company_address_id"
    t.bigint "complete_internship_id"
    t.string "supervisor_phone"
    t.index ["company_address_id"], name: "index_internships_on_company_address_id"
    t.index ["complete_internship_id"], name: "index_internships_on_complete_internship_id"
  end

  create_table "internships_programming_languages", id: false, force: :cascade do |t|
    t.integer "programming_language_id"
    t.integer "internship_id"
    t.index ["programming_language_id", "internship_id"], name: "unique_index", unique: true
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "street", limit: 255
    t.string "zip", limit: 255
    t.string "country", limit: 255
    t.string "city", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "text"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link", limit: 255
  end

  create_table "orientations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "body"
    t.string "email", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programming_languages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reading_profs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registration_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "name_de", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "sid"
  end

  create_table "students", id: :serial, force: :cascade do |t|
    t.string "enrolment_number", limit: 255
    t.string "last_name", limit: 255
    t.string "first_name", limit: 255
    t.date "birthday"
    t.string "birthplace", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "import_id"
    t.string "city"
    t.string "street"
    t.string "zip"
    t.string "phone"
    t.string "private_email"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_pass_digest", limit: 255
    t.boolean "publicmail"
    t.boolean "mailnotif"
    t.integer "student_id"
    t.string "auth_token", limit: 255
    t.string "password_reset_token", limit: 255
    t.datetime "password_reset_sent_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "internships", "company_addresses"
  add_foreign_key "internships", "complete_internships"
end
