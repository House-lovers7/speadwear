# frozen_string_literal: true

class LikecordinatesController < ApplicationController

  def create
    @cordinate = Cordinate.find(params[:id])
    @likecordinate = Likecordinate.new(likecordinate_params)
    if can? :create, @likecordinate
      @likecordinate.user_id = current_user.id
      @likecordinate.cordinate_id = @cordinate.id

      if @likecordinate.save
        create_notification_like_cordinate!(current_user,
                                            @likecordinate.user_id, @cordinate.id)
        redirect_back(fallback_location: cordinate_show_path)
      else
        flash[:danger] = 'Errorです!!'
        redirect_to request.referer
      end
    end
  end

  def destroy
    @likecordinate = Likecordinate.find_by(cordinate_id: params[:id],
                                           user_id: params[:user_id])
    if can? :destroy, @likecordinate
      @likecordinate.destroy
      redirect_to request.referer
    else
      flash[:danger] = '権限がありません!!'
      redirect_to request.referer
    end
  end

  # cordinate＿idをもっているUserをもってくる
  # いいね通知機能の実装
  def create_notification_like_cordinate!(current_user, _user_id, id)
    # すでに「いいね」されているか検索
    temp = Notification.where(['sender_id = ? and receiver_id = ? and cordinate_id = ? and action = ? ',
                               current_user.id, @cordinate.user_id, id, 'likecordinate'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        cordinate_id: id,
        receiver_id: @cordinate.user_id,
        action: 'cordinatelike'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.sender_id == notification.receiver_id
      notification.save if notification.valid?
    end
  end

  def save_notification_like_cordinate!(current_user, id, user_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      cordinate_id: @cordinate.id,
      comment_id: @comment.id,
      receiver_id: user_id,
      action: 'cordinatelike'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.sender_id == notification.receiver_id
    notification.save if notification.valid?
  end
  
  private
  def likecordinate_params
    params.permit(:user_id, :cordinate_id)
  end
end
