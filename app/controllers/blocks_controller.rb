# frozen_string_literal: true

class BlocksController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:blocked_id])
    if can? :create, @user
      @current_user.block(@user)
      @current_user.unfollow(@user)
      # redirect_to "/users/#{@user.id}"
      flash[:notice] = 'ブロックしました'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if can? :destroy, @user
      @current_user.unblock(@user)
      flash[:notice] = 'ブロックを解除しました'
      # redirect_to "/users/#{@user.id}"
    end
  end
end
