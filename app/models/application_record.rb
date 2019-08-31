# frozen_string_literal: true

# Superclass for all Models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.attributes_required_for_internship_application
    []
  end
end
