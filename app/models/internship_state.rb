# frozen_string_literal: true

#
class InternshipState < ActiveRecord::Base
  attr_accessible :name, :name_de

  has_many :internships
end
