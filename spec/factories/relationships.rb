# frozen_string_literal: true

FactoryBot.define do
  # factory :relationship1 do
  #   association :follower
  #   association :followed
  # end

  factory :relationship1, class: Relationship do
    association :user
    follower_id { admin.id }
    followed_id { other.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :relationship2, class: Relationship do
    association :user
    follower_id { blockuser.id }
    followed_id { admin.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }    
  end

  factory :relationship3, class: Relationship do
    association :user
    follower_id { other.id }
    followed_id { blockuser.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }    
  end

  factory :relationship4, class: Relationship do
    association :user
    follower_id { other.id }
    followed_id { admin.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end

# create_table "relationships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "follower_id"
#   t.integer "followed_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["followed_id"], name: "index_relationships_on_followed_id"
#   t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
#   t.index ["follower_id"], name: "index_relationships_on_follower_id"
# end

# ActiveRecord::RecordInvalid (バリデーションに失敗しました: Emailはすでに存在します)
