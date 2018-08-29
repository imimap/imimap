# frozen_string_literal: true

# https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    can :read, :all if user.prof? || user.examination_office?

    return unless user.user?

    can :create, Internship
    can :update, Internship, approved: false
    can :update, Student, user: { id: user.id }
    can :upadte, User, id: user.id
    can :create, [Company, CompanyAddress]
    can :read, InternshipOffer
  end
end
