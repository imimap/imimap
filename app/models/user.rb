# frozen_string_literal: true

# Represents a user in the imi-map.
# Users can be Students, Professors, or IMI-Map Admins.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 5 }
  # validates :student, presence: true
  has_many :internship_offers

  belongs_to :student
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :user_can_see_companies
  has_many :visible_companies,
           through: :user_can_see_companies,
           source: :company,
           inverse_of: :seeing_users

  serialize :feature_toggles
  def feature_on?(feature)
    return false unless feature_toggles

    feature_toggles.include? feature
  end

  def string_to_array(some_list)
    some_list.split(',')
             .map { |s| s.gsub(/:/, '') }
             .map(&:strip)
             .map(&:to_sym)
  end

  def feature_toggles=(new_ft)
    new_feature_toggles = case new_ft
                          when String
                            string_to_array(new_ft)
                          when Array
                            new_ft
                          else
                            []
                          end
    super(new_feature_toggles & FT.list)
  end

  def name
    if student.nil?
      email
    else
      "#{student.first_name} #{student.last_name}"
    end
  end

  EDITABLE_ATTRIBUTES = %i[email mailnotif publicmail student].freeze
  EDITABLE_ATTRIBUTES_FT = %i[feature_toggles].freeze
  EDITABLE_ATTRIBUTES_PW = %i[password password_confirmation].freeze
  EDITABLE_ATTRIBUTES_ALL = EDITABLE_ATTRIBUTES +
                            EDITABLE_ATTRIBUTES_PW +
                            EDITABLE_ATTRIBUTES_FT
  ROLES = %i[admin prof examination_office user].freeze
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  # note that student is not a role.
  def student?
    return true if student

    student_email?(email)
  end

  def enrolment_number
    return nil unless student?

    if student
      student.enrolment_number
    else
      User.enrolment_number_from(email: email)
    end
  end
  ER_IN_EMAIL = 7
  STUDENT_MAIL_REGEX = Regexp.new("s(\\d{#{ER_IN_EMAIL}})@htw-berlin.de").freeze
  def student_email?(email1)
    result = !STUDENT_MAIL_REGEX.match(email1).nil?
    logger.warn "#{email1} is student email: #{result}" if email1[0..1] == 's0'
    result
  end

  def self.email_for(enrolment_number:)
    er = enrolment_number.rjust(ER_IN_EMAIL, '0')
    "s#{er}@htw-berlin.de"
  end

  def self.enrolment_number_from(email:)
    match = STUDENT_MAIL_REGEX.match(email)
    return nil unless match

    # remove leading 0
    match[1].sub(/^0+/, '')
  end

  def self.find_or_create(email:, password:)
    user = User.where(email: email).first
    if user
      old_pw = user.encrypted_password
      user.update(password: password) unless password == old_pw
    end
    user ||= User.create(email: email,
                         password: password,
                         password_confirmation: password)
    Student.find_or_create_for(user: user) if user.student_email?(email)
    user
  end

  def accessible_complete_internships
    if admin?
      CompleteInternship.all
    else
      CompleteInternship.joins(student: :user).where('users.id' => id)
    end
  end

  # multiple recipients for action mailer
  def self.student_user
    User.where(role: "user")
  end
end
