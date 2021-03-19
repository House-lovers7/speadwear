# frozen_string_literal: true

FactoryBot.define do
  factory :cordinate1, class: Cordinate do
    user_id { admin.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_tops { 1 }
    si_bottoms { 2 }
    si_shoes { 3 }
    # si_outer {  }
    # comment_id { 1 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate1.JPG'))
    end
    # userならできるのにownerはできないのはどうしてか？
    # association :owner
    # picture
    # user { item.user }
  end

  factory :cordinate2, class: Cordinate do
    user_id { admin.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_tops { 4 }
    si_bottoms { 5 }
    si_shoes { 6 }
    # si_outer {  }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate2.JPG'))
    end
  end

  factory :cordinate3, class: Cordinate do
    user_id { admin.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_outer { 7 }
    si_tops { 8 }
    si_bottoms { 9 }
    si_shoes { 10 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate3.JPG'))
    end
  end

  factory :cordinate4, class: Cordinate do
    user_id { other.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_outer { 11 }
    si_tops { 12 }
    si_bottoms { 13 }
    si_shoes { 14 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate4.JPG'))
    end
  end

  factory :cordinate5, class: Cordinate do
    user_id { other.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_outer { 15 }
    si_tops { 16 }
    si_bottoms { 17 }
    si_shoes { 18 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate5.JPG'))
    end
  end

  factory :cordinate6, class: Cordinate do
    user_id { other.id }
    season { 0 }
    tpo { 3 }
    rating { 3 }
    si_outer { 19 }
    si_tops { 20 }
    si_bottoms { 21 }
    si_shoes { 22 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate6.JPG'))
    end
  end

  factory :cordinate7, class: Cordinate do
    user_id { blockuser.id }
    season { 0 }
    tpo { 1 }
    rating { 4 }
    si_outer { 23 }
    si_tops { 24 }
    si_bottoms { 25 }
    si_shoes { 26 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate7.JPG'))
    end
  end

  factory :cordinate8, class: Cordinate do
    user_id { blockuser.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_outer { 7 }
    si_tops { 8 }
    si_bottoms { 9 }
    si_shoes { 10 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate8.JPG'))
    end
  end

  # testuser用

  factory :cordinate9, class: Cordinate do
    user_id { testuser.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_tops { 1 }
    si_bottoms { 2 }
    si_shoes { 3 }
    # si_outer {  }
    # comment_id { 1 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate1.JPG'))
    end
    # userならできるのにownerはできないのはどうしてか？
    # association :owner
    # picture
    # user { item.user }
  end

  factory :cordinate10, class: Cordinate do
    user_id { testuser.id }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    si_tops { 1 }
    si_bottoms { 2 }
    si_shoes { 3 }
    # si_outer {  }
    # comment_id { 1 }
    sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
    association :user
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/cordinate1.JPG'))
    end
    # userならできるのにownerはできないのはどうしてか？
    # association :owner
    # picture
    # user { item.user }
  end
end

# enum super_item: %w(0outer 1tops 2bottoms 3shoes)
# enum season: %w( 0spring 1summer 2autmun 3winter )
# enum tpo: %w(0dating 1relax 2sports 3town 4work)
# enum rating: %w(1 2 3 4 5)
# enum content: %w(0tshits 1shirts 2parker 3pants 4jacket 5coat 6denimpants)

# create_table "cordinates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "user_id"
#   t.integer "item_id"
#   t.integer "season"
#   t.integer "tpo"
#   t.float "rating", limit: 24
#   t.string "memo"
#   t.string "picture"
#   t.integer "si_shoes"
#   t.integer "si_bottoms"
#   t.integer "si_tops"
#   t.integer "si_suits"
#   t.integer "si_outer"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer "comment_id"
#   t.integer "likecordinate_id"
