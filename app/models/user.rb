class User < ApplicationRecord
  # validation

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :password, presence: true
  attr_accessor :remember_token, :activation_token, :reset_token

  mount_uploader :picture, PictureUploader

  # before アクション
  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password
  has_many :cordinates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :likecordinates, dependent: :destroy
  has_many :likecomments, dependent: :destroy
  has_many :blocks, dependent: :destroy

  # 通知機能の実装
  has_many :notificatons, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'receiver_id', dependent: :destroy
  # ブロック機能の実装
  has_many :active_blocks, class_name:  'Block', foreign_key: 'blocker_id', dependent: :destroy
  has_many :passive_blocks, class_name: 'Block', foreign_key: 'blocked_id', dependent: :destroy
  has_many :blocking, through: :active_blocks, source: :blocked
end
