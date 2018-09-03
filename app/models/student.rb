# frozen_string_literal: true

# Represents a Student.
class Student < ApplicationRecord
  # attr_accessible :birthday, :birthplace, :email, :first_name,
  #                 :enrolment_number, :last_name

  # validates :last_name, :first_name, :email, :enrolment_number, presence: true
  # validates_uniqueness_of :enrolment_number

  has_many :internships
  has_one :user

  def user?
    user.present?
  end

  def name
    "#{first_name} #{last_name}"
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
end
