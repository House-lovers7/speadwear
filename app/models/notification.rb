class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :cordinate, class_name: 'Cordinate', optional: true
  belongs_to :comment, class_name: 'Comment', optional: true
  belongs_to :likecordinate, class_name: 'Likecordinate', optional: true
  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :receiver, class_name: 'User', optional: true
end
