# frozen_string_literal: true

module Abilities
  # defines abilities for plain users(students)
  class User
    include CanCan::Ability

    def initialize(user)
      complete_internship(user)
      internship(user)
      company(user)
      can :read, InternshipOffer

      can %i[show update], Student, user: { id: user.id }

      can %i[read update], User, id: user.id
    end

    def complete_internship(user)
      can %i[new create internship_data], CompleteInternship
      can %i[edit show update],
          CompleteInternship,
          student: { user: { id: user.id } }
    end

    def internship(user)
      can :internship_data, Internship
      can %i[create new], Internship
      # can :update, Internship, approved: false,  student: { user: user }
      can %i[update show], Internship, student: { user: user }
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
