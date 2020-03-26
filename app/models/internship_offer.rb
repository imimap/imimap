# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  has_rich_text :body
  belongs_to :user
  # has_one :user
end
