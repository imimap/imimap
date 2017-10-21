# frozen_string_literal: true

# The States a Certificate can be in. The states are enumerated in the database.
class CertificateState < ActiveRecord::Base
  attr_accessible :name, :name_de

  has_many :internships
end
