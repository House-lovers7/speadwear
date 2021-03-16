# frozen_string_literal: true


FactoryBot.define do
  factory :likecordinate1, class: Likecordinate do
    user_id { other.id }
    cordinate_id { cordinate1.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate2, class: Likecordinate do
    user_id { other.id }
    cordinate_id { cordinate2.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate3, class: Likecordinate do
    user_id { blockuser.id }
    cordinate_id { cordinate3.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate4, class: Likecordinate do
    user_id { blockuser.id }
    cordinate_id { cordinate4.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate5, class: Likecordinate do
    user_id { blockuser.id }
    cordinate_id { cordinate5.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate6, class: Likecordinate do
    user_id { admin.id }
    cordinate_id { cordinate6.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate7, class: Likecordinate do
    user_id { other.id }
    cordinate_id { cordinate7.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :likecordinate8, class: Likecordinate do
    user_id { other.id }
    cordinate_id { cordinate8.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end

# create_table "likecordinates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "user_id"
#   t.integer "cordinate_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["cordinate_id"], name: "index_likecordinates_on_cordinate_id"
#   t.index ["user_id", "cordinate_id"], name: "index_likecordinates_on_user_id_and_cordinate_id", unique: true
#   t.index ["user_id"], name: "index_likecordinates_on_user_id"
# end
