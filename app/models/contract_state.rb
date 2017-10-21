# frozen_string_literal: true

#
class ContractState < ActiveRecord::Base
  attr_accessible :name, :name_de

  has_many :internships
end
