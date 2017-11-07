# frozen_string_literal: true

# Prof reading the Report
class ReadingProf < ApplicationRecord
  attr_accessible :name

  has_many :internships
end
