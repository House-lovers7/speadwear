# frozen_string_literal: true

class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :cordinate, class_name: 'Cordinate', optional: true
  belongs_to :comment, class_name: 'Comment', optional: true
  belongs_to :likecordinate, class_name: 'Likecordinate', optional: true
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id', optional: true
end
