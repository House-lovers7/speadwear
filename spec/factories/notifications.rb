FactoryBot.define do
  factory :notification do
    sender_id { 1 }
    receiver_id { 1 }
    cordinate_id { 1 }
    comment_id { 1 }
    likecordinate_id { 1 }
    action { "MyString" }
    checked { false }
  end
end
