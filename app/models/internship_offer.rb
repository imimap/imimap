# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  has_one :user
  belongs_to :orientation

  mount_uploader :pdf, InternshipReportUploader
end
