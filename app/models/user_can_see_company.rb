# frozen_string_literal: true

# Limits the Access to Companies and CompanyAddresses for Users.
class UserCanSeeCompany < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :company, presence: true
  validates :user, presence: true
  # https://api.rubyonrails.org/v5.2.3/classes/ActiveRecord/Enum.html
  enum created_by: %i[unknown company_suggest company_search]
  LIMITS = { company_suggest: 5, company_search: 12 }.freeze

  def self.company_search(company_id:, user:)
    check_created_by(company_id: company_id,
                     user: user,
                     created_by: 'company_search')
  end

  def self.company_suggest(company_id:, user:)
    check_created_by(company_id: company_id,
                     user: user,
                     created_by: 'company_suggest')
  end

  def self.check_created_by(company_id:, user:, created_by:)
    company = Company.find(company_id)
    return true unless where(company: company,
                             user: user,
                             created_by: created_by).empty?
    return false unless check_limit(user: user, created_by: created_by)

    create(company: company, user: user,
           created_by: created_by)
    true
  end

  def self.check_limit(user:, created_by:)
    UserCanSeeCompany.where(user: user, created_by: created_by).count <
      LIMITS[created_by.to_sym]
  end
end
