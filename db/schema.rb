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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130704133212) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_comment_id"
    t.integer  "user_id"
    t.integer  "internship_id"
  end

  create_table "attachments", :force => true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"

  create_table "certificate_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "number_employees"
    t.string   "industry"
    t.string   "website"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.string   "street"
    t.string   "zip"
    t.string   "main_language"
    t.string   "phone"
    t.string   "fax"
    t.boolean  "blacklisted",      :default => false
    t.integer  "import_id"
  end

  create_table "contract_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "downloads", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "email_processors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "faqs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favorite_compares", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "internship_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "comparebox"
  end

  create_table "financings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "internship_offers", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "pdf"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "internship_ratings", :force => true do |t|
    t.integer  "tasks",            :limit => 1
    t.integer  "training_success", :limit => 1
    t.integer  "atmosphere",       :limit => 1
    t.integer  "supervision",      :limit => 1
    t.integer  "appreciation",     :limit => 1
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "internship_records", :force => true do |t|
    t.string   "supervisor_name"
    t.string   "supervisor_email"
    t.string   "comment"
    t.date     "certificate_to_prof"
    t.date     "certificate_signed_by_prof"
    t.date     "certificate_signed_by_internship_officer"
    t.integer  "internship_state_id"
    t.integer  "internship_id"
    t.integer  "payment_state_id"
    t.integer  "registration_state_id"
    t.integer  "contract_state_id"
    t.integer  "report_state_id"
    t.integer  "certificate_state_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "reading_prof_id"
  end

  create_table "internship_searches", :force => true do |t|
    t.string   "country"
    t.string   "city"
    t.string   "industry"
    t.string   "orientation"
    t.integer  "min_salary"
    t.integer  "max_salary"
    t.integer  "rating"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "internship_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "internships", :force => true do |t|
    t.float    "working_hours"
    t.float    "living_costs"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "internship_rating_id", :default => 1
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "title"
    t.boolean  "recommend"
    t.integer  "orientation_id"
    t.boolean  "email_public"
    t.text     "description"
    t.integer  "semester_id"
    t.string   "internship_report"
    t.integer  "salary"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "tasks"
    t.string   "operational_area"
    t.integer  "student_id"
  end

  create_table "internships_programming_languages", :id => false, :force => true do |t|
    t.integer "programming_language_id"
    t.integer "internship_id"
  end

  add_index "internships_programming_languages", ["programming_language_id", "internship_id"], :name => "unique_index", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "street"
    t.string   "zip"
    t.string   "country"
    t.string   "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.boolean  "read"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "link"
  end

  create_table "orientations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programming_languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "quicksearches", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reading_profs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registration_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "report_states", :force => true do |t|
    t.string   "name"
    t.string   "name_de"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "semester"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "enrolment_number"
    t.string   "last_name"
    t.string   "first_name"
    t.date     "birthday"
    t.string   "birthplace"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "import_id"
  end

  create_table "user_comments", :force => true do |t|
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.integer  "internship_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "password_digest"
    t.boolean  "internship_authorization", :default => true
    t.boolean  "publicmail"
    t.boolean  "mailnotif"
    t.integer  "student_id"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
