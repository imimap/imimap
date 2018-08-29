# frozen_string_literal: true

# https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    can :read, :all if user.prof? || user.examination_office?


    # all
    # TBD these reveal somewhat arbitrary
    # controller actions added over the time.
    can :internship_data, Internship
    can :student_show, User
    can :new_address, CompanyAddress

    return unless user.user?

    cannot :index, Internship
    can :create, Internship
    can :update, Internship, approved: false
    can :read,   Internship, student: { user: user }
    can :update, Student, user: { id: user.id }
    can [:read, :update], User, id: user.id
    can :create, [Company, CompanyAddress]
    can :read, InternshipOffer
  end
end
