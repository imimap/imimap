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

ActiveRecord::Schema.define(version: 2021_05_07_162535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.integer "author_id"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "namespace"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "file"
    t.string "attachable_type"
    t.integer "attachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachable_id"], name: "index_attachments_on_attachable_id"
  end

  create_table "certificate_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "number_employees"
    t.string "industry"
    t.string "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "main_language"
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
    t.boolean "aep", default: false
    t.boolean "passed", default: false
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_complete_internships_on_semester_id"
    t.index ["student_id"], name: "index_complete_internships_on_student_id"
  end

  create_table "contract_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_processors", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_compares", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "internship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "comparebox"
  end

  create_table "financings", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internship_offers", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "pdf"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internship_searches", id: :serial, force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "industry"
    t.string "orientation"
    t.integer "min_salary"
    t.integer "max_salary"
    t.integer "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internship_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internships", id: :serial, force: :cascade do |t|
    t.float "working_hours"
    t.float "living_costs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "internship_rating_id", default: 1
    t.integer "x_company_id"
    t.integer "user_id"
    t.boolean "recommend", default: true
    t.integer "orientation_id"
    t.boolean "email_public"
    t.text "description"
    t.integer "semester_id"
    t.string "internship_report"
    t.integer "salary"
    t.date "start_date"
    t.date "end_date"
    t.text "tasks"
    t.string "operational_area"
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
    t.string "supervisor_email"
    t.string "supervisor_name"
    t.boolean "completed", default: false
    t.bigint "company_address_id"
    t.bigint "complete_internship_id"
    t.string "supervisor_phone"
    t.boolean "contract_original", default: true
    t.boolean "approved", default: false
    t.index ["company_address_id"], name: "index_internships_on_company_address_id"
    t.index ["complete_internship_id"], name: "index_internships_on_complete_internship_id"
  end

  create_table "internships_programming_languages", id: false, force: :cascade do |t|
    t.integer "programming_language_id"
    t.integer "internship_id"
    t.index ["programming_language_id", "internship_id"], name: "unique_index", unique: true
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "street"
    t.string "zip"
    t.string "country"
    t.string "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "company_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "text"
    t.boolean "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "link"
  end

  create_table "orientations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postponements", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "semester_id"
    t.integer "semester_of_study"
    t.text "reasons"
    t.datetime "placed_at"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["approved_by_id"], name: "index_postponements_on_approved_by_id"
    t.index ["semester_id"], name: "index_postponements_on_semester_id"
    t.index ["student_id"], name: "index_postponements_on_student_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "body"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programming_languages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reading_profs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "paid"
    t.string "location"
    t.integer "orientation_id"
    t.integer "programming_language_id"
  end

  create_table "semesters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "sid"
  end

  create_table "students", id: :serial, force: :cascade do |t|
    t.string "enrolment_number"
    t.string "last_name"
    t.string "first_name"
    t.date "birthday"
    t.string "birthplace"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "import_id"
    t.string "city"
    t.string "street"
    t.string "zip"
    t.string "phone"
    t.string "private_email"
  end

  create_table "user_can_see_companies", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "user_id"
    t.integer "created_by", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_user_can_see_companies_on_company_id"
    t.index ["user_id"], name: "index_user_can_see_companies_on_user_id"
  end

  create_table "user_can_see_internships", force: :cascade do |t|
    t.bigint "internship_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["internship_id"], name: "index_user_can_see_internships_on_internship_id"
    t.index ["user_id"], name: "index_user_can_see_internships_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "old_pass_digest"
    t.boolean "publicmail"
    t.boolean "mailnotif"
    t.integer "student_id"
    t.string "auth_token"
    t.string "password_reset_token"
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
    t.text "feature_toggles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "internships", "company_addresses"
  add_foreign_key "internships", "complete_internships"
  add_foreign_key "postponements", "semesters"
  add_foreign_key "postponements", "students"
  add_foreign_key "postponements", "users", column: "approved_by_id"
  add_foreign_key "user_can_see_companies", "companies"
  add_foreign_key "user_can_see_companies", "users"
  add_foreign_key "user_can_see_internships", "internships"
  add_foreign_key "user_can_see_internships", "users"
end
