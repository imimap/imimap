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

ActiveRecord::Schema.define(version: 20170719063910) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_comment_id"
    t.integer  "user_id"
    t.integer  "internship_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.text     "description"
    t.string   "file",            limit: 255
    t.integer  "attachable_id"
    t.string   "attachable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id"

  create_table "certificate_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "number_employees"
    t.string   "industry",         limit: 255
    t.string   "website",          limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city",             limit: 255
    t.string   "country",          limit: 255
    t.string   "street",           limit: 255
    t.string   "zip",              limit: 255
    t.string   "main_language",    limit: 255
    t.string   "phone",            limit: 255
    t.string   "fax",              limit: 255
    t.boolean  "blacklisted",                  default: false
    t.integer  "import_id"
  end

  create_table "contract_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "downloads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_processors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_compares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "internship_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "comparebox"
  end

  create_table "financings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internship_offers", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.string   "pdf",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "internship_ratings", force: :cascade do |t|
    t.integer  "tasks",            limit: 2
    t.integer  "training_success", limit: 2
    t.integer  "atmosphere",       limit: 2
    t.integer  "supervision",      limit: 2
    t.integer  "appreciation",     limit: 2
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "internship_searches", force: :cascade do |t|
    t.string   "country",     limit: 255
    t.string   "city",        limit: 255
    t.string   "industry",    limit: 255
    t.string   "orientation", limit: 255
    t.integer  "min_salary"
    t.integer  "max_salary"
    t.integer  "rating"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "internship_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "internships", force: :cascade do |t|
    t.float    "working_hours"
    t.float    "living_costs"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.integer  "internship_rating_id",                                 default: 1
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "title",                                    limit: 255
    t.boolean  "recommend",                                            default: true
    t.integer  "orientation_id"
    t.boolean  "email_public"
    t.text     "description"
    t.integer  "semester_id"
    t.string   "internship_report",                        limit: 255
    t.integer  "salary"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "tasks"
    t.string   "operational_area",                         limit: 255
    t.integer  "student_id"
    t.integer  "internship_state_id"
    t.integer  "reading_prof_id"
    t.integer  "payment_state_id"
    t.integer  "registration_state_id"
    t.integer  "contract_state_id"
    t.integer  "report_state_id",                                      default: 1
    t.integer  "certificate_state_id"
    t.date     "certificate_signed_by_internship_officer"
    t.date     "certificate_signed_by_prof"
    t.date     "certificate_to_prof"
    t.string   "comment",                                  limit: 255
    t.string   "supervisor_email",                         limit: 255
    t.string   "supervisor_name",                          limit: 255
    t.boolean  "completed",                                            default: false
  end

  create_table "internships_programming_languages", id: false, force: :cascade do |t|
    t.integer "programming_language_id"
    t.integer "internship_id"
  end

  add_index "internships_programming_languages", ["programming_language_id", "internship_id"], name: "unique_index", unique: true

  create_table "locations", force: :cascade do |t|
    t.string   "street",     limit: 255
    t.string   "zip",        limit: 255
    t.string   "country",    limit: 255
    t.string   "city",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "company_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.boolean  "read"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "link",       limit: 255
  end

  create_table "orientations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "programming_languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "quicksearches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reading_profs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registration_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "report_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "name_de",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "enrolment_number", limit: 255
    t.string   "last_name",        limit: 255
    t.string   "first_name",       limit: 255
    t.date     "birthday"
    t.string   "birthplace",       limit: 255
    t.string   "email",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "import_id"
  end

  create_table "user_comments", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "internship_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "old_pass_digesr",        limit: 255
    t.boolean  "publicmail"
    t.boolean  "mailnotif"
    t.integer  "student_id"
    t.string   "auth_token",             limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "encrypted_password",                 default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "superuser",                          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
