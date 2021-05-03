# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @cordinate = Cordinate.find(params[:id])
    @comment = Comment.new(comment_params)
    # 自分にはコメントできないようにする。
    if current_user == @cordinate.user
      flash[:danger] = '自分のコーデにはコメントはできません。'
      redirect_back(fallback_location: cordinate_show_path)
      return
    end

    if can? :create, @comment
      @comment.user_id = current_user.id
      @comment.cordinate_id = @cordinate.id

      if @comment.save!
        # 通知機能の実装
        create_notification_comment(current_user, @comment.user_id,
                                    @cordinate.id)
        redirect_back(fallback_location: cordinate_show_path)
      else
        flash[:danger] = 'Errorです!!'
      end
      # redirect_back(fallback_location: cordinate_show_path) unless @comment.save!
    end
  end

  # コメント通知機能の実装
  def create_notification_comment(current_user, user_id, id)
    # 自分を除き、コメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(cordinate_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, user_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, user_id, id) if temp_ids.blank?
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
                               user_id: current_user.id)
    redirect_to request.referer if cannot? :destroy, @comment
    @comment.destroy
    redirect_back(fallback_location: cordinate_show_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :cordinate_id)
  end
end
