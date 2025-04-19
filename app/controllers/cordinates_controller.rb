# frozen_string_literal: true

class CordinatesController < ApplicationController
  before_action :logged_in_user, only: %i[create edit update destroy]
  before_action :friend_user, only: %i[new edit create]
  before_action :blocking?, only: %i[show]

  def index
    @item = Item.where(user_id: (params[:user_id].presence || current_user.id))
    item_cordinate_ransack_setup
  end

  def show
    @comments = @cordinate.comments.includes(:user)
    @comment = @comments.first
    @likecordinates = Likecordinate.where(cordinate_id: @cordinate.id)
    @likecordinates_count = @likecordinates.count
    @user = @cordinate.user
    cordinate_si_picture_set
  end

  def all_cordinate_show
    cordinate_paginate
    item_cordinate_ransack_setup
  end

  def user_all_cordinate_show
    @cordinates = Cordinate.where(user_id: (params[:user_id].presence || current_user.id)).page(params[:page])
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
    @cordinate.user_id = current_user.id
    cordinate_si_params_set

    if @cordinate.save
      if @cordinate.picture.present?
        ImageProcessingJob.perform_async(@cordinate.id)
      end
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
    if @cordinate.update(cordinate_params)
      flash[:success] = 'コーデをアプデしました!'
      redirect_to cordinate_show_path(user_id: @cordinate.user.id, id: @cordinate.id)
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def cordinate_save
    @cordinate = Cordinate.find(params[:id])
    if @cordinate.update(cordinate_update_params)
      flash[:success] = 'コーデをアプデしました!'
      redirect_to cordinate_show_path(user_id: @cordinate.user.id, id: @cordinate.id)
    else
      redirect_to request.referer, notice: @cordinate.errors.full_messages.to_s
    end
  end

  def reset_si_items
    [:si_outer, :si_tops, :si_bottoms, :si_shoes].each do |attr|
      @cordinate.send("#{attr}=", nil)
    end
  end

  # 作成したコーディネートのitemのpictureを編集する
  def item_edit
    @cordinate = Cordinate.find(params[:id])
    authorize! :create, @cordinate, message: '他人のコーデを編集する権限がありません。'
    cordinate_si_picture_set
  end

  def item_update
    @cordinate = Cordinate.find(params[:id])
    if @cordinate.update(cordinate_update_params)
      flash[:success] = 'コーデのアイテムをアプデしました!'
      redirect_to cordinate_item_edit_path(id: params[:id], item_id: params[:item_id])
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
    @p_cordinate_season = perform_ransack(Cordinate, :p_season, :p_season)
  end

  def cordinate_tpo_ransack
    @p_cordinate_tpo = perform_ransack(Cordinate, :p_tpo, :p_tpo)
  end

  def cordinate_rating_ransack
    @p_cordinate_rating = perform_ransack(Cordinate, :p_rating, :p_rating)
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
    @q_item_season = perform_ransack(Item, :q_season, :q_season)
  end

  def item_tpo_ransack
    @q_item_tpo = perform_ransack(Item, :q_tpo, :q_tpo)
  end

  def item_rating_ransack
    @q_item_rating = perform_ransack(Item, :q_rating, :q_rating)
  end

  def item_color_ransack
    @q_item_color = perform_ransack(Item, :q_color, :q_color)
  end

  def item_super_item_ransack
    @q_item_super_item = perform_ransack(Item, :q_super_item, :q_super_item)
  end

  # Itemのransack設定------------

  def cordinate_paginate
    @cordinates = Cordinate.all.page(params[:page])
  end

  private

  def cordinate_params
    params.require(:cordinate).permit(:item_id, :season, :tpo, :rating, :memo, :picture, :favorite,
                                      :si_outer, :si_shoes, :si_bottoms, :si_tops, items_attributes: [:id])
  end

  def cordinate_update_params
    params.permit(:item_id, :season, :tpo, :rating, :memo, :picture, :si_outer, :si_shoes,
                  :si_bottoms, :si_tops, items_attributes: [:id])
  end

  def comment_params
    params.permit(:comment, :user_id, :cordinate_id)
  end

  def cordinate_si_params_set
    { cordinate_si_outer: :si_outer,
      cordinate_si_tops: :si_tops,
      cordinate_si_bottoms: :si_bottoms,
      cordinate_si_shoes: :si_shoes
    }.each do |param_key, attribute|
      if params[param_key].present?
        @cordinate.send("#{attribute}=", params[param_key])
      end
    end
  end

  def cordinate_si_picture_set
    { si_bottoms: 'si_bottoms', si_tops: 'si_tops', si_outer: 'si_outer', si_shoes: 'si_shoes' }.each do |attr, ivar_name|
      value = @cordinate.send(attr)
      if value.present?
        item = Item.find_by(id: value)
        instance_variable_set("@#{ivar_name}", item.picture.url) if item && item.picture
      end
    end
  end

  def perform_ransack(model, param_key, search_key)
    if params[param_key].present?
      model.ransack(params[param_key], search_key: search_key).result
    else
      model.where(user_id: (params[:user_id].presence || current_user.id))
    end
  end
end
