# frozen_string_literal: true

# Represents the application of internship Postponement
class Postponement < ApplicationRecord
  belongs_to :student
  has_one :complete_internship, through: :student
  belongs_to :semester
  belongs_to :approved_by, class_name: 'User', foreign_key: :approved_by_id
end
