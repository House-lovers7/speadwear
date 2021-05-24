# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user,
                only: %i[edit update destroy following followers]
  before_action :correct_user, only: %i[edit update]
  before_action :check_guest, only:  %i[destroy update]

  def index
    @cordinate = Cordinate.where(user_id: params[:user_id])
    @item = Item.where(user_id: params[:user_id])
    @users = User.all
    user_paginate
    cordinate_ransack_setup
    item_ransack_setup
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def blocking
    @title = 'blocking'
    @user = User.find(params[:id])
    @users = @user.blocking
    render 'show_follow'
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to @user
    else
      redirect_to request.referer
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :delete, @user, message: 'ユーザーを削除する権限がありません。'
    @user.destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  #  Cordinateのransackの設定------------

  def all_cordinate_season_search
    cordinate_season_ransack
  end

  def all_cordinate_tpo_search
    cordinate_tpo_ransack
  end

  def all_cordinate_rating_search
    cordinate_rating_ransack
  end

  def cordinate_ransack_setup
    cordinate_season_ransack
    cordinate_tpo_ransack
    all_cordinate_rating_search
  end

  def cordinate_season_ransack
    p_cordinate_season = Cordinate.ransack(params[:p_season],
                                           search_key: :p_season)
    @p_cordinate_season = p_cordinate_season.result
    @cordinate = Cordinate.where(user_id: current_user.id) if params[:p_season].blank?
  end

  def cordinate_tpo_ransack
    p_cordinate_tpo = Cordinate.ransack(params[:p_tpo], search_key: :p_tpo)
    @p_cordinate_tpo = p_cordinate_tpo.result
    @cordinate = Cordinate.where(user_id: current_user.id) if params[:p_tpo].blank?
  end

  def cordinate_rating_ransack
    p_cordinate_rating = Cordinate.ransack(params[:p_rating],
                                           search_key: :p_rating)
    @p_cordinate_rating = p_cordinate_rating.result
    @cordinate = Cordinate.where(user_id: current_user.id) if params[:p_rating].blank?
  end

  # Itemのransack設定------------

  def all_item_tpo_search
    item_tpo_ransack
  end

  def all_item_season_search
    item_season_ransack
  end

  def all_item_color_search
    item_color_ransack
  end

  def all_item_rating_search
    item_rating_ransack
  end

  def all_item_super_item_search
    item_super_item_ransack
  end

  def item_ransack_setup
    item_tpo_ransack
    item_rating_ransack
    item_season_ransack
    item_super_item_ransack
    item_color_ransack
  end

  def item_season_ransack
    q_item_season = Item.ransack(params[:q_season], search_key: :q_season)
    @q_item_season = q_item_season.result
    @item = Item.where(user_id: current_user.id) if params[:q_season].blank?
  end

  def item_tpo_ransack
    q_item_tpo = Item.ransack(params[:q_tpo], search_key: :q_tpo)
    @q_item_tpo = q_item_tpo.result
    @item = Item.where(user_id: current_user.id) if params[:q_tpo].blank?
  end

  def item_rating_ransack
    q_item_rating  = Item.ransack(params[:q_rating], search_key: :q_rating)
    @q_item_rating = q_item_rating.result
    @item = Item.where(user_id: current_user.id) if params[:q_rating].blank?
  end

  def item_color_ransack
    q_item_color = Item.ransack(params[:q_color], search_key: :q_color)
    @q_item_color = q_item_color.result
    @item = Item.where(user_id: current_user.id) if params[:q_color].blank?
  end

  def item_super_item_ransack
    q_item_super_item = Item.ransack(params[:q_super_item],
                                     search_key: :q_super_item)
    @q_item_super_item = q_item_super_item.result
    @item = Item.where(user_id: current_user.id) if params[:q_super_item].blank?
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :picture)
  end

  def sign_in(_user)
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def owner_user
    @user = User.find(params[:id])
    @owner_user = user
    flash[:danger] = 'オーナーしか編集できません.' unless owner_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def check_guest
    if current_user.email == 'guest@example.com'
      redirect_to root_path,
                  alert: 'ゲストユーザーは削除や編集処理。'
    end
  end

  def user_paginate
    @users = User.all.page(params[:page])
  end
end
