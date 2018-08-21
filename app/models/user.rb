# frozen_string_literal: true

# Represents a user in the imi-map.
# Users can be Students, Professors, or IMI-Map Admins.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 5 }
  # validates :student, presence: true

  belongs_to :student
  has_many :user_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :read_lists, dependent: :destroy
  has_many :finish_lists, dependent: :destroy

  def name
    if student.nil?
      email
    else
      "#{student.first_name} #{student.last_name}"
    end
  end

  def enrolment_number
    return nil unless student
    student.enrolment_number
  end
  EDITABLE_ATTRIBUTES = [:email, :mailnotif, :publicmail, :student, :role]
  EDITABLE_ATTRIBUTES_PW = [:email, :mailnotif, :publicmail, :student, :role, :password, :password_confirmation]

  ROLES=%i[admin prof examination_office user]
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end
end
