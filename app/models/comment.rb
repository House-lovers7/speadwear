# frozen_string_literal: true

class Comment < ApplicationRecord
  
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: true
  belongs_to :cordinate
  has_many :notifications, dependent: :destroy  
  validates :user_id, presence: true
  validates :cordinate_id, presence: true
  validates :comment, presence: true,
                      length: { maximum: 140 }
                                      
  # いいね通知機能の実装
  def create_notification_comment(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['sender_id = ? and receiver_id = ? and comment_id = ? and action = ? ',
                               current_user.id, user_id, id, 'commentlike'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        comment_id: id,
        receiver_id: user_id,
        action: 'commentlike'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.sender_id == notification.receiver_id
      notification.save if notification.valid?
    end
  end
end
