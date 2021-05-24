# frozen_string_literal: true

class Likecordinate < ApplicationRecord
  validates :user_id, presence: true
  validates :cordinate_id, presence: true
  has_many :notifications, dependent: :destroy
  belongs_to :cordinate
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: true

  belongs_to :follower, class_name: 'User', foreign_key: 'user_id',
                        optional: true
  belongs_to :followed, class_name: 'User', foreign_key: 'user_id',
                        optional: true
end
