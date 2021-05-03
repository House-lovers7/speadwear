# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    if can? :create, @relationships
    user = User.find(params[:followed_id])
    current_user.follow(user)
    # フォロー通知機能
    user.create_notification_follow!(current_user)
    redirect_to user
    # format.html { redirect_to @user }
    # format.js
  end
  end

  def destroy
    if can? :destroy, @relationships
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
  end
end
