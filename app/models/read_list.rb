# frozen_string_literal: true

class ReadList < ApplicationRecord
  # attr_accessible :user_id, :internship_id

  validates_uniqueness_of :internship_id, scope: :user_id

  validates :user, presence: true
  validates :internship, presence: true

  belongs_to :user
  belongs_to :internship
end
