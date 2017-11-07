# frozen_string_literal: true

# Answers are answers to comments to an internship.
class Answer < ApplicationRecord
  validates :body, presence: true
  validates :internship_id, presence: true
  validates :user_comment_id, presence: true

  belongs_to :user_comment
  belongs_to :user
  belongs_to :internship
end
