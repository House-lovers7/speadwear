# frozen_string_literal: true

class Block < ApplicationRecord
  validates :blocker_id, presence: true
  validates :blocked_id, presence: true
  belongs_to :blocker, class_name: 'User',  optional: true
  belongs_to :blocked, class_name: 'User',  optional: true

  private
  # 自分自身をブロックしていないか検証する
  def self_block
    return unless blocker_id && blocked_id
    errors.add(:blocked_id, '自分自身をブロックすることはできません') if blocker_id == blocked_id
  end
end
