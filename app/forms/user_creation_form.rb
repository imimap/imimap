class UserCreationForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :given_enrolment_number, :existing_student, :student

  def initialize(enrolment_number)
    @given_enrolment_number = enrolment_number
    @existing_student = Student.where(:enrolment_number => enrolment_number).first
    @student = new_or_existing
  end

  def persisted?
    false
  end

  validates :email, :presence => true
  validates :password, :presence => true, length: { minimum: 5 }
  validates :password_confirmation, :presence => true

  validates :first_name, :last_name, :enrolment_number, :birthday, :birthplace, presence: true, :if => Proc.new { |student| Student.where(enrolment_number: student.enrolment_number).first == nil }


  delegate :email, :password, :password_confirmation, :publicmail, :mailnotif,  to: :user

  delegate :first_name, :enrolment_number, :last_name, :birthday, :birthplace, to: :student

  def user
    @user ||= User.new
  end

  def new_or_existing
    if existing_student
      # This code will probably never be reached due to before filters in UsersController
      # :nocov:
      existing_student
      # :nocov:
    else
      Student.new(enrolment_number: given_enrolment_number)
    end
  end

  def submit(params)
    student.attributes = params.slice(:first_name, :last_name, :birthplace, :birthday)
    student.email =  params[:student_email]
    student.enrolment_number = given_enrolment_number
    user.attributes = params.slice(:email, :password, :password_confirmation, :publicmail, :mailnotif)
    if valid?
      student.save! unless student_exists?
      user.student_id = student.id
      #TBD what happens if save fails? why is this not in usual create action?
      #it fails if password confirmation is not correct.
      #TBD: write test for that.
      #BK 130517
      user.save!
      true
    else
      false
    end
  end

  def student_email
    student.email
  end

  def id
    user.id
  end

  def student_exists?
    existing_student.present?
  end

end
