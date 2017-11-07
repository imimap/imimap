# frozen_string_literal: true

# Represents a Student.
class Student < ApplicationRecord
  # attr_accessible :birthday, :birthplace, :email, :first_name,
  #                 :enrolment_number, :last_name

  # validates :last_name, :first_name, :email, :enrolment_number, presence: true
  # validates_uniquness_of :enrolment_number

  has_many :internships
  has_one :user

  def user?
    user.present?
  end

  def name
    "#{first_name} #{last_name}"
  end
end
