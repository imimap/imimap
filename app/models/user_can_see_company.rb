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

  def self.user_associated_with_company(user:, company:)
    associated_companies(user: user).include? company
  end

  def self.associated_companies(user:)
    associated_company_addresses(user: user).map(&:company)
  end

  def self.associated_company_addresses(user:)
    return [] if (s = user.student).nil?

    s.internships.map(&:company_address).reject(&:nil?)
  end

  def self.associated_users_for_company(company:)
    company.company_addresses.map do |ca|
      associated_users_for_company_address(company_address: ca)
    end.flatten
  end

  def self.associated_users_for_company_address(company_address:)
    company_address.internships.map { |i| i.student.user }
  end

  def self.number_of_viewed_companies_for_user(user:, created_by:)
    UserCanSeeCompany.where(user: user, created_by: created_by).count
  end

  def self.limit(created_by:)
    LIMITS[created_by.to_sym]
  end
end
