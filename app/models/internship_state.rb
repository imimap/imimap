# frozen_string_literal: true

# The state of internship processing.
class InternshipState < ActiveRecord::Base
  # TBD: translations should be in the I18n
  attr_accessible :name, :name_de

  has_many :internships
end
