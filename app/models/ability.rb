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
    # 下がなぜか機能する
    can :create, Item, user_id: @user_id # like managing all comments in the website
    can :create, Cordinate, user_id: @user_id # like managing all comments in the website
    return unless user.admin?
    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end

# テストの記述方法
# 全てを意味するAllやmanaegeのような使い方はできないのか？

# require "cancan/matchers"

# ability.should be_able_to(:read, Item.new)
# ability.should be_able_to(:read, Cordinate.new)
# ability.should be_able_to(:read, User.new)

# ability.should be_able_to(:destroy, Item.new(user: user))
# ability.should_not be_able_to（:destroy, Item.new)

# 権限を上にしてドンドン与えていくイメージ　cannnotは :manageや:allで与えたけど、例外を設ける場合につける

# できる人とできない人がいるアクションに関しては、全て条件分岐を試す。
#  adminがいるため,read以外は全てという理解でおk？_

# Best Practice
#   def initialize(user)
#     can :read, Post  # start by defining rules for all users, also not logged ones
#     return unless user.present?
#     can :manage, Post, user_id: user.id # if the user is logged in can manage it's own posts
#     can :create, Comment # logged in users can also create comments
#     return unless user.manager? # if the user is a manager we give additional permissions
#     can :manage, Comment # like managing all comments in the website
#     return unless user.admin?
#     can :manage, :all # finally we give all remaining permissions only to the admins
#   end
# end
