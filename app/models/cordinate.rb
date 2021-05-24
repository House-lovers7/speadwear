# frozen_string_literal: true

class Cordinate < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :likecordinates, dependent: :destroy
  has_many :users, through: :likecordinates

  validates :season, presence: true
  validates :tpo, presence: true
  validates :memo, length: { maximum: 140 }
  validate :picture_size

  has_many :liked_cordinate, through: :likecordinates, source: :cordinate
  has_many :accepts_comments, through: :comments, source: :cordinate

  has_many :active_likecordinates, class_name: 'Likecordinate',
                                   foreign_key: 'cordinate_id',
                                   dependent: :destroy

  # liked_usersによってcordinateが誰にいいねされているのかを簡単に取得できるようにする
  has_many :liked_users, through: :likecordinates, source: :user

  # commented_usersによってcordinateが誰にコメントされているのかを簡単に取得できるようにする
  has_many :commented_users, through: :comments, source: :user

  mount_uploader :picture, PictureUploader

  accepts_nested_attributes_for :items
  enum super_item: %w[アウター トップス ボトムス シューズ]
  enum season: %w[春 夏 秋 冬]
  enum tpo: %w[デート リラックス♪ スポーツ おでかけ 仕事]
  enum rating: %w[1 2 3 4 5]

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
