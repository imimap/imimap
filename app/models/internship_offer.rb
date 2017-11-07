# frozen_string_literal: true

# for job offers.
class InternshipOffer < ApplicationRecord
  attr_accessible :title, :body, :pdf

  has_one :user

  mount_uploader :pdf, InternshipReportUploader
end
