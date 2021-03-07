# frozen_string_literal: true

FactoryBot.define do
  factory :comment1, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate1.id }
    # sequence(:cordiante_id) { |n| cordinate#{n}.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment2, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate2.id }
    sequence(:comment) { |_n| 'ナイスな差し色!!' }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment3, class: Comment do
    user_id { blockuser.id }
    cordinate_id { cordinate3.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment4, class: Comment do
    user_id { admin.id }
    cordinate_id { cordinate4.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment5, class: Comment do
    user_id { admin.id }
    cordinate_id { cordinate5.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment6, class: Comment do
    user_id { blockuser.id }
    cordinate_id { cordinate6.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment7, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate7.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment8, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate8.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment9, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate9.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end

  factory :comment10, class: Comment do
    user_id { other.id }
    cordinate_id { cordinate10.id }
    sequence(:comment) { |n| "これは#{n}個目のコメントです。" }
    association :cordinate
    user { cordinate.user }
  end
end

# create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.string "comment"
#   t.integer "user_id"
#   t.integer "cordinate_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
