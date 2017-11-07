# frozen_string_literal: true

# Represents a user in the imi-map.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :student, presence: true

  belongs_to :student
  has_many :user_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :read_lists, dependent: :destroy
  has_many :finish_lists, dependent: :destroy

  def name
    "#{student.first_name} #{student.last_name}"
  end

  def enrolment_number
    return nil unless student
    student.enrolment_number
  end
end
