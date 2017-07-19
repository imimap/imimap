class UsersController < ApplicationController
  before_filter :check_permission, only: [:new, :create]
  before_filter :check_existing_user, only: [:new, :create]

  def new
    @user = User.new
    # old code
    # @user_creation_form = UserCreationForm.new(session[:enrolment_number])
    # respond_to do |format|
    #   format.html
    # end
  end

  def create
    @user = User.new
    @user.save!

    # old code
    # @user_creation_form = UserCreationForm.new(session[:enrolment_number])
    # if @user_creation_form.submit(params[:user_creation_form])
    #   #UserMailer.registration_confirmation(@user).deliver
    #   session[:user_id] = @user_creation_form.id
    #   redirect_to overview_index_path, notice: t('sign_up')
    # else
    #   render :new
    # end
  end

  def show
    @user = User.find(params[:id])
    @internships = @user.student.internships
    @comments = @user.user_comments
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Details were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

end
