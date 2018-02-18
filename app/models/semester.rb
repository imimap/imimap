# frozen_string_literal: true

# The Semester the Internship is assigned to
class Semester < ApplicationRecord
  has_many :internships
end
