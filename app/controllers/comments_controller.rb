# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :friend_user, only: %i[new create]
  before_action :blocking?, only: %i[create]

  def create
    @cordinate = Cordinate.find(params[:id])
    @comment = Comment.new(comment_params)
    # 自分にはコメントできないようにする。
    if current_user == @cordinate.user
      flash[:danger] = '自分のコーデにはコメントはできません。'
      redirect_back(fallback_location: cordinate_show_path(user_id: params[:user_id]))
      return
    end

    if can? :create, @comment
      @comment.user_id = current_user.id
      @comment.cordinate_id = @cordinate.id

      if @comment.save!
        # 通知機能の実装
        create_notification_comment(current_user, @comment.user_id,
                                    @cordinate.id)
        redirect_back(fallback_location: cordinate_show_path(user_id: params[:user_id]))
      else
        flash[:danger] = 'Errorです!!'
      end
      redirect_back(fallback_location: cordinate_show_path(user_id: params[:user_id])) unless @comment.save!
    end
  end

  # コメント通知機能の実装
  def create_notification_comment(current_user, _user_id, id)
    temp = Notification.where(['sender_id = ? and receiver_id = ? and cordinate_id = ? and action = ? ',
                               current_user.id, @cordinate.user_id, id, 'comment'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        cordinate_id: id,
        receiver_id: @cordinate.user_id,
        action: 'comment'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.sender_id == notification.receiver_id
      notification.save if notification.valid?
    end
  end

  def save_notification_comment(current_user, _id, user_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      cordinate_id: @cordinate.id,
      comment_id: @comment.id,
      receiver_id: user_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.sender_id == notification.receiver_id
    notification.save if notification.valid?
  end

  def destroy
    @comment = Comment.find_by(cordinate_id: params[:id],
                               user_id: params[:user_id])

    if can? :destroy, @comment
      @comment.destroy
      redirect_to request.referer
    else
      flash[:danger] = '権限がありません!!'
      redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :cordinate_id)
  end
end
