# frozen_string_literal: true

# State of the Internship Contract
class ContractState < ApplicationRecord
  # attr_accessible :name, :name_de

  has_many :internships
end
