# frozen_string_literal: true

module Abilities
  # defines abilities for plain users(students)
  class User
    include CanCan::Ability

    def initialize(user)
      can_create_internship(user)
      can_show_own_internship(user)
      can_edit_own_internship(user)
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

    def can_edit_own_internship(user)
      can %i[edit update],
          CompleteInternship,
          student: { user: { id: user.id } }
      can %i[edit update], Internship, student: { user: user }

      # can :update, Internship, approved: false,  student: { user: user }
    end

    def map(_user)
      can :map_cities, Internship
    end

    def company(user)
      can %i[create_and_save new create select_company suggest
             suggest_address save_address], [Company, CompanyAddress]
      can :show, CompanyAddress
      can %i[edit show update],
          [Company, CompanyAddress],
          internships: { complete_internship: { student: { user: user } } }
      can :new_address, CompanyAddress
    end
  end
end
