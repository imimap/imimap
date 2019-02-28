# frozen_string_literal: true

# Students can create a rating for their internship
class InternshipRating < ApplicationRecord
  # attr_accessible :appreciation, :atmosphere, :supervision, :tasks,
  #                :training_success

  has_many :internships

  validates :appreciation, :atmosphere, :supervision, :tasks, :training_success,
            numericality: { greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 5 }

  def total_rating
    atts = [tasks, training_success, atmosphere, supervision, appreciation]
    return nil if atts.any?(&:!)

    atts.inject(&:+).to_f / 5
  end
end
