# frozen_string_literal: true

class User < ApplicationRecord
  # validation

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
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
  has_many :blocks, dependent: :destroy

  # 通知機能の実装
  has_many :notificatons, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'receiver_id', dependent: :destroy
  # ブロック機能の実装
  has_many :active_blocks, class_name:  'Block', foreign_key: 'blocker_id', dependent: :destroy
  has_many :passive_blocks, class_name: 'Block', foreign_key: 'blocked_id', dependent: :destroy
  has_many :blocking, through: :active_blocks, source: :blocked

  def already_liked?(_cordinate)
    cordinate = @cordinate
    likecordinates.exists?(cordinate_id: cordinate_id)
  end

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  # :sourceパラメーター を使って、following配列の元はfolledのidの集合体であることを明示する
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # commentlikeの実装
  has_many :active_likecordinates, class_name: 'Likecordinate',
                                   foreign_key: 'user_id',
                                   dependent: :destroy
  # liked_cordinatesによってuserがどのコーデをいいねしているのかを簡単に取得できるようになります。

  # likeされているcordinateを取得するから、likedcordinate
  has_many :liked_cordinates, through: :likecordinates, source: :cordinate

  # liked_commentsによってuserがどのコメントをいいねしているのかを簡単に取得できるようになります。
  # likeされているコメントを取得するから、likedcomment

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # ユーザをブロックする
  def block(user)
    blocks.create(blocker_id: current_user.id, blocked_id: user.id)
  end

  # def follow(other_userの模倣
  # def block(other_user)
  #   active_blocks.create(blocked_id: other_user.id)
  # end

  # ユーザをブロック解除する
  def unblock(user)
    blocks.find_by(blocker_id: current_user.id, blocked_id: user.id).destroy if blocking?(user)
  end

  # def unfollow(other_userの模倣
  # def block(other_user)
  #   active_blocks.find_by(blocked_id: other_user.id).destroy
  # end

  # ユーザをブロックしていたらtrueを返す
  def blocking?(user)
    blocking.include?(user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def comment_delete(other_user)
    comments.find_by(user_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # かんたんログインの実装
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # パスワードが正規表現を満たすか確認する
  def password_regex
    valid_password_regex = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{10,20}\z/.freeze
    return nil if valid_password_regex.match(password)

    errors.add(:password, 'は半角10~20文字英大文字・小文字・数字をそれぞれ１文字以上含む必要があります')
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # アカウントを有効にする
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: FILL_IN, reset_sent_at: FILL_IN)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # フォロー通知機能
  def create_notification_follow!(current_user)
    temp = Notification.where(['sender_id = ? and receiver_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        receiver_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
