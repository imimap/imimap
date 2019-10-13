# frozen_string_literal: true

# https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

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
    can :update, Internship, student: { user: user }
    can :show,   Internship, student: { user: user }
    can :map_cities, Internship
  end

  def company(user)
    can %i[create_and_save new create select_company suggest
           suggest_address save_address], [Company, CompanyAddress]
    can %i[edit show update],
        [Company, CompanyAddress],
        internships: { complete_internship: { student: { user: user } } }
    can :new_address, CompanyAddress
  end

  def initialize(user)
    return unless user.present?

    complete_internship(user)
    internship(user)
    company(user)
    can :read, InternshipOffer

    can %i[show update], Student, user: { id: user.id }

    can %i[read update], User, id: user.id

    return unless user.prof? || user.examination_office? || user.admin?

    can :index, Internship
    can :list, Internship
    can :read, :all

    return unless user.admin?

    can :manage, :all
    can :map_internships, Internship
  end

  def internship_abilities(user)
    can :create, Internship
    can :update, Internship, approved: false, student: { user: user }
    can :show,   Internship, complete_internship: { student: { user: user } }
  end
end
