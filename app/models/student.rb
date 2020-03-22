# frozen_string_literal: true

# Represents a Student.
class Student < ApplicationRecord
  # attr_accessible :birthday, :birthplace, :email, :first_name,
  #                 :enrolment_number, :last_name, :private_email

  attr_accessor

  def self.attributes_required_for_internship_application
    %i[first_name last_name birthday birthplace enrolment_number]
  end

  # validates :last_name, :first_name, :email, :enrolment_number, presence: true
  # validates_uniqueness_of :enrolment_number

  has_one :complete_internship
  has_many :internships, through: :complete_internship
  has_many :postponements, dependent: :destroy
  has_one :user

  validates :private_email, format: { with: Devise.email_regexp },
                            allow_blank: true

  def user?
    user.present?
  end

  def birthday?
    birthday.try(:month) == Date.today.month &&
      birthday.try(:day) == Date.today.day
  end

  def name
    name = "#{first_name} #{last_name}"
    name == ' ' ? email : name
  end

  def self.find_or_create_for(user:)
    return user.student if user.student

    email = user.email
    enrolment_number = User.enrolment_number_from(email: email)
    student = Student.where(enrolment_number: enrolment_number)
                     .first_or_create(enrolment_number: enrolment_number,
                                      email: email)
    user.student = student
    user.save!
    student
  end

  def last_internship
    return nil if internships.empty?

    internship_ids = internships.pluck(:id)
    Internship.find(internship_ids.max)
  end

  def all_personal_details_filled?
    !([first_name, last_name, birthday, birthplace].any?(&:nil?) ||
    [first_name, last_name, birthplace].any?(&:empty?))
  end
end
