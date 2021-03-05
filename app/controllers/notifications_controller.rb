class NotificationsController < ApplicationController
    def index
      @user = User.find_by(id: current_user.id)
      #current_userの投稿に紐づいた通知一覧
      @notifications = current_user.passive_notifications
      #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
        cordinate_id = notification.cordinate_id
      end
  
      item_cordinate_ransack_setup
    end
  
    def show
      @user = User.find_by(id: current_user.id)
      #current_userの投稿に紐づいた通知一覧
      @notifications = current_user.passive_notifications
      #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
        cordinate_id = notification.cordinate_id
      end
      item_cordinate_ransack_setup
    end
  
    def destroy_all
      redirect_to request.referer if cannot? :destroy, @notification
      #通知を全削除
      @notifications = current_user.passive_notifications.destroy_all
      redirect_to request.referer
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
      if params[:p_season].blank?
        @cordinate = Cordinate.where(user_id: params[:user_id])
      end
    end
  
    def cordinate_tpo_ransack
      p_cordinate_tpo = Cordinate.ransack(params[:p_tpo], search_key: :p_tpo)
      @p_cordinate_tpo = p_cordinate_tpo.result
      if params[:p_tpo].blank?
        @cordinate = Cordinate.where(user_id: params[:user_id])
      end
    end
  
    def cordinate_rating_ransack
      p_cordinate_rating = Cordinate.ransack(params[:p_rating], search_key: :p_rating)
      @p_cordinate_rating = p_cordinate_rating.result
      if params[:p_rating].blank?
        @cordinate = Cordinate.where(user_id: params[:user_id])
      end
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
      if params[:q_season].blank?
        @item = Item.where(user_id: params[:user_id])
      end
    end
  
    def item_tpo_ransack
      q_item_tpo = Item.ransack(params[:q_tpo], search_key: :q_tpo)
      @q_item_tpo = q_item_tpo.result
      if params[:q_tpo].blank?
        @item = Item.where(user_id: params[:user_id])
      end
    end
  
    def item_rating_ransack
      q_item_rating = Item.ransack(params[:q_rating], search_key: :q_rating)
      @q_item_rating = q_item_rating.result
      if params[:q_rating].blank?
        @item = Item.where(user_id: params[:user_id])
      end
    end
  
    def item_color_ransack
      q_item_color = Item.ransack(params[:q_color], search_key: :q_color)
      @q_item_color = q_item_color.result
      if params[:q_color].blank?
        @item = Item.where(user_id: params[:user_id])
      end
    end
  
    def item_super_item_ransack
      q_item_super_item = Item.ransack(params[:q_super_item], search_key: :q_super_item)
      @q_item_super_item = q_item_super_item.result
      if params[:q_super_item].blank?
        @item = Item.where(user_id: params[:user_id])
      end
    end
  
    # Itemのransack設定------------
  
  end
  
  # has_many :passive_notifications, class_name: "Notification", foreign_key: "receiver_id", dependent: :destroy
  