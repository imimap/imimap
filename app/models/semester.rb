# frozen_string_literal: true

#
class Semester < ActiveRecord::Base
  attr_accessible :name

  #validates :name, presence: true

  has_many :internships
end
