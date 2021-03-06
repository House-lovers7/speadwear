# frozen_string_literal: true

class CordinatesController < ApplicationController
  before_action :logged_in_user, only: %i[create edit delete update]
  before_action :friend_user, only: %i[new edit create]
  before_action :blocking?, only: %i[show]

  def index
    @item = Item.where(user_id: params[:user_id])
    item_cordinate_ransack_setup
  end

  def show
    @cordinate = Cordinate.find(params[:id])
    # @comment ||= Comment.new(comment_params)
    @comment = Comment.find_by(cordinate_id: params[:id])
    @comments = @cordinate.comments
    @cordinate_comments = Comment.where(cordinate_id: params[:id])
    @likecordinates = Likecordinate.where(cordinate_id: params[:id])
    @likecordinates_count = Likecordinate.where(cordinate_id: params[:id]).count
    @user = User.find_by(id: @cordinate.user.id)
    params[:user_id] = @user.id
    cordinate_si_picture_set
    comment = @comments.where(user_id: @cordinate.commented_users.ids)
  end

  def all_cordinate_show
    cordinate_paginate
    item_cordinate_ransack_setup
  end

  def user_all_cordinate_show
    @cordinates = Cordinate.where(user_id: params[:user_id]).page(params[:page])
    item_cordinate_ransack_setup
  end

  def new
    @cordinate = Cordinate.new
    @cordinate.user_id = current_user.id
    authorize! :create, @cordinate, message: '他人のコーデを作成する権限がありません.'
  end

  def create
    @cordinate = Cordinate.new(cordinate_params)
    @comment = Comment.new(comment_params)
    @comments = @cordinate.comments
    @comment.user_id = current_user.id
    @item = Item.where(super_item: params[:super_item])
    @cordinate.user_id = params[:user_id]
    cordinate_si_params_set

    unless params[:picture].nil?
      img = MiniMagick::Image.read(params[:picture])
      img.resize_to_fill '169x225'
    end

    if @cordinate.save
      flash[:success] = 'コーデを作成しました!'
      redirect_to cordinate_show_path(user_id: @cordinate.user.id, id: @cordinate.id)
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def edit
    @cordinate = Cordinate.find(params[:id])
    authorize! :update, @cordinate, message: '他人のコーデを更新する権限がありません.'
    redirect_to request.referer if cannot? :update, @cordinate
    cordinate_si_picture_set
  end

  def update
    @cordinate = Cordinate.find(params[:id])
    cordinate_si_params_set
    if @cordinate.update_attributes(cordinate_params)
      @cordinate.save
      flash[:success] = 'コーデをアプデしました!'
      redirect_to cordinate_show_path(user_id: @cordinate.user.id, id: @cordinate.id)
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def cordinate_save
    @cordinate = Cordinate.find(params[:id])
    if @cordinate.update_attributes(cordinate_update_params)
      @cordinate.save
      flash[:success] = 'コーデをアプデしました!'
      redirect_to cordinate_show_path(user_id: @cordinate.user.id, id: @cordinate.id)
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def reset_si_items
    @cordinate.si_outer = nil
    @cordinate.si_tops = nil
    @cordinate.si_bottoms = nil
    @cordinate.si_shoes = nil
  end

  # 作成したコーディネートのitemのpictureを編集する
  def item_edit
    @cordinate = Cordinate.find(params[:id])
    authorize! :create, @cordinate, message: '他人のコーデを編集する権限がありません。'
    cordinate_si_picture_set
  end

  def item_update
    @cordinate = Cordinate.find(params[:id]) || Cordinate.new
    @cordinate.update_attributes(cordinate_update_params)

    if @cordinate.save
      flash[:success] = 'コーデのアイテムをアプデしました!'
      redirect_to cordinate_item_edit_path(id: params[:id],
                                           item_id: params[:item_id])
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def destroy
    @cordinate = Cordinate.find(params[:id])
    authorize! :delete, @cordinate, message: '他人のコーデを削除する権限がありません。'
    redirect_to request.referer if cannot? :destroy, @cordinate
    @cordinate.destroy
    flash[:success] = 'コーデを削除しました!'
    redirect_to all_cordinate_show_path(user_id: current_user.id)
  end

  # ransackの設定------------------------

  def item_cordinate_ransack_setup
    item_ransack_setup
    cordinate_ransack_setup
  end

  def item_ransack_setup
    item_tpo_ransack
    item_rating_ransack
    item_season_ransack
    item_super_item_ransack
    item_color_ransack
  end

  def cordinate_ransack_setup
    cordinate_season_ransack
    cordinate_tpo_ransack
    cordinate_rating_ransack
  end

  #  Cordinateのransackの設定--------------

  def all_cordinate_season_search
    cordinate_season_ransack
    item_cordinate_ransack_setup
  end

  def all_cordinate_tpo_search
    cordinate_tpo_ransack
    item_cordinate_ransack_setup
  end

  def all_cordinate_rating_search
    cordinate_rating_ransack
    item_cordinate_ransack_setup
  end

  def cordinate_season_ransack
    p_cordinate_season = Cordinate.ransack(params[:p_season],
                                           search_key: :p_season)
    @p_cordinate_season = p_cordinate_season.result
    @cordinate = Cordinate.where(user_id: params[:user_id]) if params[:p_season].blank?
  end

  def cordinate_tpo_ransack
    p_cordinate_tpo = Cordinate.ransack(params[:p_tpo], search_key: :p_tpo)
    @p_cordinate_tpo = p_cordinate_tpo.result
    @cordinate = Cordinate.where(user_id: params[:user_id]) if params[:p_tpo].blank?
  end

  def cordinate_rating_ransack
    p_cordinate_rating = Cordinate.ransack(params[:p_rating],
                                           search_key: :p_rating)
    @p_cordinate_rating = p_cordinate_rating.result
    @cordinate = Cordinate.where(user_id: params[:user_id]) if params[:p_rating].blank?
  end

  # Itemのransack設定--------------

  def all_item_tpo_search
    item_tpo_ransack
    item_cordinate_ransack_setup
  end

  def all_item_season_search
    item_season_ransack
    item_cordinate_ransack_setup
  end

  def all_item_color_search
    item_color_ransack
    item_cordinate_ransack_setup
  end

  def all_item_rating_search
    item_rating_ransack
    item_cordinate_ransack_setup
  end

  def all_item_super_item_search
    item_super_item_ransack
    item_cordinate_ransack_setup
  end

  def item_season_ransack
    q_item_season = Item.ransack(params[:q_season], search_key: :q_season)
    @q_item_season = q_item_season.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_season].blank?
  end

  def item_tpo_ransack
    q_item_tpo = Item.ransack(params[:q_tpo], search_key: :q_tpo)
    @q_item_tpo = q_item_tpo.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_tpo].blank?
  end

  def item_rating_ransack
    q_item_rating  = Item.ransack(params[:q_rating], search_key: :q_rating)
    @q_item_rating = q_item_rating.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_rating].blank?
  end

  def item_color_ransack
    q_item_color = Item.ransack(params[:q_color], search_key: :q_color)
    @q_item_color = q_item_color.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_color].blank?
  end

  def item_super_item_ransack
    q_item_super_item = Item.ransack(params[:q_super_item],
                                     search_key: :q_super_item)
    @q_item_super_item = q_item_super_item.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_super_item].blank?
  end

  # Itemのransack設定------------

  def cordinate_paginate
    @cordinates = Cordinate.all.page(params[:page])
  end

  private

  def cordinate_params
    params.require(:cordinate).permit(:user_id, :item_id, :season, :tpo, :rating, :memo, :picture, :favorite,
                                      :si_outer, :si_shoes, :si_bottoms, :si_tops, items_attributes: [:id])
  end

  def cordinate_update_params
    params.permit(:user_id, :item_id, :season, :tpo, :rating, :meamo, :picture, :si_outer, :si_shoes,
                  :si_bottoms, :si_tops, items_attributes: [:id])
  end

  def comment_params
    params.permit(:comment, :user_id, :cordinate_id)
  end

  def cordinate_si_params_set
    if params[:cordinate_si_outer]
      @cordinate.si_outer = params['cordinate_si_outer']
    elsif params[:cordinate_si_tops]
      @cordinate.si_tops =  params['cordinate_si_tops']
    elsif params[:cordinate_si_bottoms]
      @cordinate.si_bottoms = params['cordinate_si_bottoms']
    elsif params[:cordinate_si_shoes]
      @cordinate.si_shoes = params['cordinate_si_shoes']
    end
  end

  def cordinate_si_picture_set
    if @cordinate.si_bottoms
      @item = Item.find_by(id: @cordinate.si_bottoms)
      @si_bottoms = @item.picture.url
    end

    if @cordinate.si_tops
      @item = Item.find_by(id: @cordinate.si_tops)
      @si_tops = @item.picture.url
    end

    if @cordinate.si_outer
      @item = Item.find_by(id: @cordinate.si_outer)
      @si_outer = @item.picture.url
    end

    if @cordinate.si_shoes
      @item = Item.find_by(id: @cordinate.si_shoes)
      @si_shoes = @item.picture.url
    end
  end
end
