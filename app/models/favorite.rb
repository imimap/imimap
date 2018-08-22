# frozen_string_literal: true

class Favorite < ApplicationRecord
  # attr_accessible :user_id, :internship_id, :comparebox

  validates :user, presence: true
  validates :internship, presence: true

  belongs_to :user
  belongs_to :internship
end
