# frozen_string_literal: true

class LikecordinatesController < ApplicationController
  def create
    @cordinate = Cordinate.find(params[:id])
    @likecordinate = Likecordinate.new(likecordinate_params)
    if can? :create, @likecordinate
      @likecordinate.user_id = current_user.id
      @likecordinate.cordinate_id = @cordinate.id

      if @likecordinate.save

        # いいね通知の
        # @cordinate.create_notification_like_cordinate!(current_user)
        # @cordinate.create_notification_like_cordinate!
        create_notification_like_cordinate!(current_user,
                                            @likecordinate.user_id, @cordinate.id)
        redirect_to request.referer
        # redirect_back(fallback_location: cordinate_show_path)
        # 通知機能の実装
      else
        flash[:danger] = 'Errorです!!'
        redirect_to request.referer
      end
    end
  end

  def destroy
    @likecordinate = Likecordinate.find_by(cordinate_id: params[:id],
                                           user_id: current_user.id)
    redirect_to request.referer if cannot? :destory, @likecordinate
    if can? :destroy, @likecordinate
      @likecordinate.destroy
      redirect_to request.referer
    else
      flash[:danger] = '権限がありません!!'
      redirect_to request.referer
    end
  end

  # いいね通知機能の実装
  def create_notification_like_cordinate!(current_user, user_id, id)
    # すでに「いいね」されているか検索
    temp = Notification.where(['sender_id = ? and receiver_id = ? and cordinate_id = ? and action = ? ',
                               current_user.id, user_id, id, 'likecordinate'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        cordinate_id: id,
        receiver_id: user_id,
        action: 'cordinatelike'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.sender_id == notification.receiver_id
      notification.save if notification.valid?
    end
  end

  private

  def likecordinate_params
    # params.require(:likecordinate).permit(:user_id, :cordinate_id)
    params.permit(:user_id, :cordinate_id)
  end
end
