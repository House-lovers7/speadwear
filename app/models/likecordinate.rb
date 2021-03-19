# frozen_string_literal: true

class Likecordinate < ApplicationRecord
  # has_one :user, through: :cordinate
  has_many :notifications, dependent: :destroy
  belongs_to :cordinate
  # belongs_to :user

  # Validationの設定
  validates :user_id, presence: true
  validates :cordinate_id, presence: true

  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: true

  belongs_to :follower, class_name: 'User', foreign_key: 'user_id',
                        optional: true
  belongs_to :followed, class_name: 'User', foreign_key: 'user_id',
                        optional: true

  # create_table "likecordinates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  #   t.integer "user_id"
  #   t.integer "cordinate_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["cordinate_id"], name: "index_likecordinates_on_cordinate_id"
  #   t.index ["user_id", "cordinate_id"], name: "index_likecordinates_on_user_id_and_cordinate_id", unique: true
  #   t.index ["user_id"], name: "index_likecordinates_on_user_id"
  # end

  # #いいね通知機能の実装
  # def create_notification_like_cordinate!(current_user, user_id, id)
  #   # すでに「いいね」されているか検索
  #   temp = Notification.where(["sender_id = ? and receiver_id = ? and cordinate_id = ? and action = ? ", current_user.id, user_id, id, "likecordinate"])
  #   # いいねされていない場合のみ、通知レコードを作成
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       cordinate_id: id,
  #       receiver_id: user_id,
  #       action: "cordinatelike",
  #     )
  #     # 自分の投稿に対するいいねの場合は、通知済みとする
  #     if notification.sender_id == notification.receiver_id
  #       notification.checked = true
  #     end
  #     notification.save if notification.valid?
  #     # redirect_to cordinate_show_path
  #     redirect_to @user
  #   end
  # end
end
