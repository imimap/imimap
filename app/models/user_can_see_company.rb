# frozen_string_literal: true

# Limits the Access to Companies and CompanyAddresses for Users.
class UserCanSeeCompany < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :company, presence: true
  validates :user, presence: true
  # https://api.rubyonrails.org/v5.2.3/classes/ActiveRecord/Enum.html
  enum created_by: %i[unknown company_suggest]

  def self.suggest(company_id:, user:)
    company = Company.find(company_id)
    return true unless where(company: company, user: user).empty?
    return false unless check_limit(user: user)

    create(company: company, user: user,
           created_by: 'company_suggest')
    true
  end

  def self.check_limit(user:)
    UserCanSeeCompany.where(user: user).count < 5
  end
end
