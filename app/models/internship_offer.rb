# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  belongs_to :user
  # has_one :user
end
