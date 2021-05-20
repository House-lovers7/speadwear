# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, :all # start by defining rules for all users, also not logged ones
    return unless user.present?
    can :manage, :all, user_id: user.id # if the user is logged in can manage it's own posts
    cannot :destroy, :all # if the user is logged in cannot destroy all
    can :destroy, :all, user_id: user.id # if the user is logged in can destroy it's own posts
    can :create, :Likecordinate # if the user is logged in can create likecordinate
    can :create, Comment # like managing all comments in the website
    can :create, Cordinate # like managing all comments in the website
    return unless user.admin?
    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end
