# frozen_string_literal: true

module Abilities
  # defines abilities for plain users(students)
  class User
    include CanCan::Ability

    def initialize(user)
      can_create_internship(user)
      can_show_own_internship(user)
      can_edit_own_complete_internship(user)
      can_edit_destroy_own_internship(user)

      map(user)
      company(user)
      can :read, InternshipOffer

      can %i[show update], Student, user: { id: user.id }

      can %i[read update], User, id: user.id
    end

    def can_create_internship(_user)
      can %i[new create show_own], CompleteInternship
      can %i[create new], Internship
    end

    def can_show_own_internship(user)
      can %i[show_own], CompleteInternship
      can %i[show],
          CompleteInternship,
          student: { user: { id: user.id } }
      can %i[show], Internship, student: { user: user }
    end

    def can_edit_own_complete_internship(user)
      can %i[edit update],
          CompleteInternship do |ci|
            # student: { user: { id: user.id } }
            if ci.student.user == user
              !ci.aep
            else
              false
            end
          end
    end

    def can_edit_destroy_own_internship(user)
      # evtl. vereinfachen zu
      # can :update, Internship, approved: false,  student: { user: user }
      can %i[edit update destroy], Internship do |internship|
        if internship.complete_internship.student.user == user
          !internship.approved && internship.registration_state.nil?
        else
          false
        end
      end
    end

    def map(_user)
      can :map_cities, Internship
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

    def company(user)
      can_create_company(user)
      can_edit_associated_company(user)
      can_edit_associated_company_address(user)
      can_show_company(user)
      can_show_limited_number_of_companies(user)
    end
  end
end
