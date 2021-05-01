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

  # 友達フラグを立てる
  def friend_user
    
    @user = @current_user || User.find_by(id: session[:user_id])
    
    if @user.following.include?(current_user) || @user == current_user || user.admin?
    else
      flash[:success] = '権限がありません!!'
      redirect_to request.referer
    end
  end

  # 管理者かどうか確認
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

  # ブロック機能の実装
  # has_many :active_blocks, class_name:  "Block", foreign_key: "blocker_id", dependent: :destroy
  # has_many :passive_blocks, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy
  # has_many :blocking, through: :active_blocks, source: :blocked

  #   has_many :active_blocks, class_name: "Block",
  #   foreign_key: "blocker_id",
  #   dependent: :destroy
  # has_many :blocking, through: :active_blocks, source: :blocked

  # authorize_resource :class => false

  #   # root_urlにかっ飛ばす。
  #   redirect_to root_url
  # end
end
