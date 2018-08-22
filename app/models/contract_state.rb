# frozen_string_literal: true

class ContractState < ApplicationRecord
  # attr_accessible :name, :name_de

  has_many :internships
end
