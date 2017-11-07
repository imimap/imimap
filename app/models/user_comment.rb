# frozen_string_literal: true

# Comments for Internships in ActiveAdmin
class UserComment < ApplicationRecord
  validates :body, presence: true
  validates :internship_id, presence: true

  belongs_to :internship
  belongs_to :user

  has_one :answer, dependent: :destroy
end
