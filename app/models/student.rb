# frozen_string_literal: true

# Represents a Student.
class Student < ApplicationRecord
  # attr_accessible :birthday, :birthplace, :email, :first_name,
  #                 :enrolment_number, :last_name, :privateemail

  attr_accessor

  # validates :last_name, :first_name, :email, :enrolment_number, presence: true
  # validates_uniqueness_of :enrolment_number


  has_one :complete_internship
  has_many :internships
  has_many :internships_new, through: :complete_internship
  has_one :user

  validates :privateemail, format: { with: Devise.email_regexp },
  allow_blank: true

  def user?
    user.present?
  end

  def name
    if user.nil?
      email
    else
      "#{first_name} #{last_name}"
    end
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
end
