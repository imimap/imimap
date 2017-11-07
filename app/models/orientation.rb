# frozen_string_literal: true

# TBD: What does this model do?
class Orientation < ApplicationRecord
  attr_accessible :name

  validates :name, presence: true

  has_many :internships
end
