# frozen_string_literal: true

# State of Internship Registration
class RegistrationState < ApplicationRecord
  # attr_accessible :name, :name_de

  has_many :internships
end
