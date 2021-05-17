# frozen_string_literal: true

class BlocksController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:blocked_id])    
      @current_user.block(@user)    
      
      if current_user.following?(@user)  
      @current_user.unfollow(@user) 
      end
      
      redirect_to "/users/#{@user.id}"
      flash[:notice] = 'ブロックしました'    
  end

  def destroy    
    user = Block.find(params[:id]).blocked
    current_user.unblock(user)
    flash[:notice] = 'ブロックを解除しました'
    redirect_to user
  end    
end



