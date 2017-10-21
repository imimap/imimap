# frozen_string_literal: true

#
class ReadingProf < ActiveRecord::Base

  attr_accessible :name

  has_many :internships

end
