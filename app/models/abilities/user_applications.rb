# frozen_string_literal: true

# Ability definitions for Users
module Abilities
  # defines abilities for plain users(students)
  class UserApplications
    include CanCan::Ability

    def initialize(user)
      can_create_and_show_own_postponement(user)

      company(user)
    end

    def can_create_and_show_own_postponement(_user)
      can %i[new create], Postponement
    end

    def company(user)
      can_create_company(user)
      can_edit_associated_company(user)
      can_edit_associated_company_address(user)
      can_show_company(user)
      can_show_limited_number_of_companies(user)
    end

    def can_create_company(user)
      can %i[new create select_company suggest], [Company]
      can %i[create_and_save new create new_address
             suggest_address save_address], [CompanyAddress]
      can %i[edit show update],
          [Company, CompanyAddress],
          internships: { complete_internship: { student: { user: user } } }
    end

    def can_edit_associated_company(user)
      # only while approved: false
      can %i[edit update], Company do |company|
        users = UserCanSeeCompany.associated_users_for_company(company: company)
        if users.include? user
          users.none? { |u| u != user }
        else
          false
        end
      end
    end

    def can_edit_associated_company_address(user)
      can %i[edit update], CompanyAddress do |ca|
        users = UserCanSeeCompany.associated_users_for_company_address(
          company_address: ca
        )
        if users.include? user
          users.none? { |u| u != user }
        else
          false
        end
      end
    end

    def can_show_company(user)
      can :show,
          [Company, CompanyAddress],
          internships: { complete_internship: { student: { user: user } } }
    end

    def can_show_limited_number_of_companies(user)
      can :show, CompanyAddress do |company_address|
        UserCanSeeCompany.where(user: user,
                                company: company_address.company,
                                created_by: 'company_suggest').exists?
      end
      can :show, Company do |company|
        UserCanSeeCompany.where(user: user,
                                company: company,
                                created_by: 'company_suggest').exists?
      end
    end
  end
end
