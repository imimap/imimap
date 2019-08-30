# frozen_string_literal: true

# Superclass for all Models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.attributes_required_for_save
    validators.select do |validator|
      validator.is_a?(ActiveRecord::Validations::PresenceValidator)
    end.map(&:attributes).flatten
  end

  def self.attributes_required_for_internship_application
    @@attributes_required_for_internship_application
  end

end
