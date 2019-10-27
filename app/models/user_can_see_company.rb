# frozen_string_literal: true

# Limits the Access to Companies and CompanyAddresses for Users.
class UserCanSeeCompany < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :company, presence: true
  validates :user, presence: true
  # https://api.rubyonrails.org/v5.2.3/classes/ActiveRecord/Enum.html
  enum created_by: %i[unknown company_suggest]
end
