class UsersController < ApplicationController
  before_action :check_permission, only: [:new, :create]
  before_action :check_existing_user, only: [:new, :create]

  def create
    @user = User.new(user_params)
    @user.save!
  end

  def show
    @user = User.find(params[:id])
    @internships = @user.student.internships
    @comments = @user.user_comments
  end

  private

  def check_permission
    redirect_to root_url unless session[:enrolment_number].present?
  end

  def check_existing_user
    if session[:enrolment_number]
      student = Student.where(enrolment_number: session[:enrolment_number]).first
      redirect_to root_url, error: "Users exists. Please sign in with your email and password"  if student && User.find_by_student_id(student.id)
    end
  end

  def user_params
    params.require(:user).permit(:email, :publicmail, :mailnotif, :student_id)
    # this was listed here, but probably the shorter list above works just fine:
    # attr_accessible :email, :password, :password_confirmation, :publicmail,
    #                :mailnotif, :student_id, :remember_me
  end
end
# create_table "users", force: :cascade do |t|
#   t.string   "email",                  default: "",    null: false
#   t.datetime "created_at"
#   t.datetime "updated_at"
#   t.string   "old_pass_digesr"
#   t.boolean  "publicmail"
#   t.boolean  "mailnotif"
#   t.integer  "student_id"
#   t.string   "auth_token"
#   t.string   "password_reset_token"
#   t.datetime "password_reset_sent_at"
#   t.string   "encrypted_password",     default: "",    null: false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          default: 0,     null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.string   "current_sign_in_ip"
#   t.string   "last_sign_in_ip"
#   t.boolean  "superuser",              default: false
# end
