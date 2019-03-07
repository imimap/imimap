# frozen_string_literal: true

# https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :create, [Company, CompanyAddress]
    can :read, InternshipOffer
    can :map_cities, Internship

    # TBD these reveal somewhat arbitrary
    # controllers and controller actions added over the time.
    can :internship_data, Internship
    can :new_address, CompanyAddress

    can %i[show update], Student, user: { id: user.id }

    can :create, Internship
    can :update, Internship, approved: false,  student: { user: user }
    can :show,   Internship, student: { user: user }
    # can %i[show update], Student, user: user
    # can :update, Student, user: { id: user.id }
    can %i[read update], User, id: user.id

    return unless user.prof? || user.examination_office? || user.admin?

    can :index, Internship
    can :list, Internship
    can :read, :all

    return unless user.admin?

    can :manage, :all
  end
end
