# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, alert: exception.message }
    end
  end

   # 正しいユーザーかどうか確認
   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # 友達フラグを立てる
  def friend_user
    @user = @current_user || User.find_by(id: session[:user_id])
    if @user.following.include?(current_user) || @user == current_user || user.admin?
    else
      flash[:success] = '権限がありません!!'
      redirect_to request.referer
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

    def blocking?                  
    current_user      
    @user = User.find(params[:user_id])
    active_block_ids = @current_user.active_blocks
    passive_blocke_ids = @current_user.passive_blocks
    # 自分 = @current_userが相手　= @userをブロックしている　or 相手が自分をブロックしていたら表示していたら、メソッドを発動
    if active_block_ids.where(blocked_id: @user.id).exists? || passive_blocke_ids.where(blocker_id: @user.id).exists?    
      flash[:notice] = 'このユーザをブロックしているかブロックされているため、アクションができません。'
      redirect_to request.referer
    end
  end
end
