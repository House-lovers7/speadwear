# frozen_string_literal: true

class ItemsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :edit, :delete, :update]

  def index
    item_paginate
    @cordinate = Cordinate.where(user_id: params[:user_id])
    item_cordinate_ransack_setup
  end

  def all_item_show
    item_paginate
    item_cordinate_ransack_setup
  end

  def user_all_item_show
    @items = Item.where(user_id: params[:user_id]).page(params[:page])
    item_cordinate_ransack_setup
  end

  # item_color_ransack

  def new
    @item = Item.new

    authorize! :create, @item, message: '他人のアイテムを作成する権限がありません。'
    @item.user_id = params[:user_id]
  end

  def create
    binding.pry

    @item = Item.new(item_params)
    @item.user_id = params[:user_id]

    unless params[:picture].nil?
      img = MiniMagick::Image.read(params[:picture])
      img.resize_to_fill '169x225'
    end

    @item.save
    # ratingの評価がなければ1をつける
    # @item.rating= 1 if @item.rating.nil?
    # @item.save!
    flash[:success] = 'Itemを作成しました!'

    # redirect_to item_show_path( user_id: params[:user_id], id: @item.id)
  end

  def show
    @item = Item.find(params[:id])
    cordinate_ransack_setup
  end

  def item_show
    @item = Item.find(params[:user_id])
    item_ransack_setup
    cordinate_ransack_setup F
  end

  def cordinate_show
    @item = Item.find_by(id: params[:id])
    @cordinate = Cordinate.find(params[:cordinate_id])
  end

  def edit
    @item = Item.find(params[:id])

    authorize! :update, @item, message: '他人のアイテムを編集する権限がありません。'
    # cacneは何をしているのか?
    @item.picture.cache! unless @item.picture.blank?
  end

  def update
    # @item = item.new(item_params)

    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = 'Item Updated'
      redirect_to item_show_path(user_id: params[:user_id], id: @item.id)

    else
      redirect_to request.referer
    end
  end

  def destroy
    @item = Item.find(params[:id])
    authorize! :delete, @item, message: '他人のアイテムを削除する権限がありません。'
    # 消したら同じ IDはなくなるやん!!!!
    redirect_to request.referer if cannot? :destroy, @item
    @item.destroy
    flash[:success] = 'Item deleted'
  end

  def cordinate_search_si
    q_cordinate = Item.ransack(params[:q])
    # @items = Item.find(params[:user_id])
    case params[:q]
    when { 'super_item_eq' => '0' }
      @item = Item.where(user_id: params[:user_id], super_item: 0)
    when { 'super_item_eq' => '1' }
      @item = Item.where(user_id: params[:user_id], super_item: 1)
    when { 'super_item_eq' => '2' }
      @item = Item.where(user_id: params[:user_id], super_item: 2)
    when { 'super_item_eq' => '3' }
      @item = Item.where(user_id: params[:user_id], super_item: 3)
    end
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
    # all_cordinate_rating_search
  end

  #  Cordinateのransackの設定--------------

  def all_cordinate_season_search
    cordinate_season_ransack
  end

  def all_cordinate_tpo_search
    cordinate_tpo_ransack
  end

  def all_cordinate_rating_search
    cordinate_rating_ransack
  end

  def cordinate_season_ransack
    p_cordinate_season = Cordinate.ransack(params[:p_season], search_key: :p_season)
    @p_cordinate_season = p_cordinate_season.result
    @cordinate = Cordinate.where(user_id: params[:user_id]) if params[:p_season].blank?
  end

  def cordinate_tpo_ransack
    p_cordinate_tpo = Cordinate.ransack(params[:p_tpo], search_key: :p_tpo)
    @p_cordinate_tpo = p_cordinate_tpo.result
    @cordinate = Cordinate.where(user_id: params[:user_id]) if params[:p_tpo].blank?
  end

  def cordinate_rating_ransack
    p_cordinate_rating = Cordinate.ransack(params[:p_rating], search_key: :p_rating)
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
    q_item_super_item = Item.ransack(params[:q_super_item], search_key: :q_super_item)
    @q_item_super_item = q_item_super_item.result
    @item = Item.where(user_id: params[:user_id]) if params[:q_super_item].blank?
  end

  # Itemのransack設定------------

  def item_paginate
    @items = Item.all.page(params[:page])
  end

  private

  def item_params
    params.require(:item).permit(:id, :user_id, :super_item, :season, :tpo, :storage, :rating, :color, :memo,
                                 :picture, :content)
  end
end
