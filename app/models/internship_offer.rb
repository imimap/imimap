# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  has_one :user
  has_one :orientation

  mount_uploader :pdf, InternshipReportUploader
end
