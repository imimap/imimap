# frozen_string_literal: true

# The Semester the Internship is assigned to
class Semester < ApplicationRecord
  attr_accessible :name

  # validates :name, presence: true

  has_many :internships
end
