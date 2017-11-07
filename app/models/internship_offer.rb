# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  has_one :user

  mount_uploader :pdf, InternshipReportUploader
end
