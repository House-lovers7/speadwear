# frozen_string_literal: true


FactoryBot.define do
  # factory :item do
  #   user_id { 2 }
  #   cordinate_id { 1 }
  #   super_item { 1 }
  #   season { 1 }
  #   tpo { 1 }
  #   rating { 1 }
  #   color { 1 }
  #   content { 1 }
  #   # sequence(:memo) { |n| "これは#{n}個目のコーディネートです" }
  #   association :cordinate
  #   user { cordinate.user }
  #   # picture { 1 }
  # end

  # item = FactoryBot.create(:item1)
  # cordinate = FactoryBot.create(:cordinate, user_id: user.id, item_id: item1.id)

  factory :item1, class: Item do
    id      { 1 }
    user_id { admin.id }
    cordinate_id { cordinate1.id }
    super_item { 1 }
    season { 2 }
    tpo { 3 }
    rating { 4 }
    color { 1 }
    content { 3 }
    memo { '差し色グリーンがナイス!' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate1_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
    # picture { 1 }
  end

  # rails db:migrate:reset RAILS_ENV=test

  factory :item2, class: Item do
    id      { 2 }
    user_id { admin.id }
    cordinate_id { cordinate1.id }
    super_item { 2 }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    color { 1 }
    content { 6 }
    memo { '着まわしと着心地がGood!' }
    # sequence(:content) { |n| "これは#{n}個目のアイテムです" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate1_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
    # picture { 1 }
  end

  factory :item3, class: Item do
    id      { 3 }
    user_id { admin.id }
    cordinate_id { cordinate1.id }
    super_item { 3 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 3 }
    content { 11 }
    memo { '履くのが超楽ちん♪' }
    # sequence(:content) { |n| "これは#{n}個目のアイテムです" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate1_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item4, class: Item do
    id      { 4 }
    user_id { admin.id }
    cordinate_id { cordinate2.id }
    super_item { 1 }
    season { 1 }
    tpo { 1 }
    rating { 4 }
    color { 8 }
    content { 4 }
    memo { 'オレンジの差し色スウェット' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate2_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item5, class: Item do
    id      { 5 }
    user_id { admin.id }
    cordinate_id { cordinate2.id }
    super_item { 2 }
    season { 2 }
    tpo { 1 }
    rating { 4 }
    color { 0 }
    content { 6 }
    memo { 'サイドラインにグリーンのアクセント' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate2_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item6, class: Item do
    id      { 6 }
    user_id { admin.id }
    cordinate_id { cordinate2.id }
    super_item { 2 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 2 }
    content { 10 }
    memo { 'コーデを選ばないシューズ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate2_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item7, class: Item do
    id      { 7 }
    user_id { admin.id }
    cordinate_id { cordinate3.id }
    super_item { 0 }
    season { 2 }
    tpo { 3 }
    rating { 3 }
    color { 2 }
    content { 9 }
    memo { '街になじむグレー' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate3_outer.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item8, class: Item do
    id      { 8 }
    user_id { admin.id }
    cordinate_id { cordinate3.id }
    super_item { 1 }
    season { 2 }
    tpo { 3 }
    rating { 3 }
    color { 0 }
    content { 0 }
    memo { 'インナー用のブラック' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate3_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item9, class: Item do
    id      { 9 }
    user_id { admin.id }
    cordinate_id { cordinate3.id }
    super_item { 2 }
    season { 2 }
    tpo { 3 }
    rating { 3 }
    color { 0 }
    content { 6 }
    memo { 'レザーブラックデニム' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate3_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item10, class: Item do
    id      { 10 }
    user_id { admin.id }
    cordinate_id { cordinate3.id }
    super_item { 2 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 2 }
    content { 10 }
    memo { 'コーデを選ばないシューズ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate3_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item11, class: Item do
    id      { 11 }
    user_id { other.id }
    cordinate_id { cordinate4.id }
    super_item { 1 }
    season { 1 }
    tpo { 0 }
    rating { 4 }
    color { 5 }
    content { 1 }
    memo { '爽やかなライトシャツ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate4_outer.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item12, class: Item do
    id      { 12 }
    user_id { other.id }
    cordinate_id { cordinate4.id }
    super_item { 1 }
    season { 1 }
    tpo { 0 }
    rating { 4 }
    color { 0 }
    content { 2 }
    memo { '鉄板のラルフのブラック' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate4_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item13, class: Item do
    id      { 13 }
    user_id { other.id }
    cordinate_id { cordinate4.id }
    super_item { 2 }
    season { 2 }
    tpo { 3 }
    rating { 3 }
    color { 2 }
    content { 7 }
    memo { '都会の味グレー' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate4_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item14, class: Item do
    id      { 14 }
    user_id { other.id }
    cordinate_id { cordinate4.id }
    super_item { 3 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 2 }
    content { 10 }
    memo { 'コーデを選ばないシューズ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate4_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item15, class: Item do
    id      { 15 }
    user_id { other.id }
    cordinate_id { cordinate5.id }
    super_item { 0 }
    season { 2 }
    tpo { 3 }
    rating { 4 }
    color { 0 }
    content { 8 }
    memo { 'ベロアのカーディガンスタイル' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate5_outer.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item16, class: Item do
    id      { 16 }
    user_id { other.id }
    cordinate_id { cordinate5.id }
    super_item { 1 }
    season { 2 }
    tpo { 3 }
    rating { 4 }
    color { 1 }
    content { 0 }
    memo { 'アニマルワンポイントのロンT' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate5_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item17, class: Item do
    id      { 17 }
    user_id { other.id }
    cordinate_id { cordinate5.id }
    super_item { 2 }
    season { 0 }
    tpo { 2 }
    rating { 3 }
    color { 0 }
    content { 10 }
    memo { '着回しGooodな迷彩' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate5_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item18, class: Item do
    id      { 18 }
    user_id { other.id }
    cordinate_id { cordinate5.id }
    super_item { 3 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 2 }
    content { 10 }
    memo { 'コーデを選ばないシューズ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate5_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item19, class: Item do
    id      { 19 }
    user_id { other.id }
    cordinate_id { cordinate6.id }
    super_item { 0 }
    season { 0 }
    tpo { 0 }
    rating { 4 }
    color { 1 }
    content { 8 }
    memo { 'ホワイトアクセント' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate6_outer.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item20, class: Item do
    id      { 20 }
    user_id { other.id }
    cordinate_id { cordinate6.id }
    super_item { 1 }
    season { 1 }
    tpo { 0 }
    rating { 4 }
    color { 4 }
    content { 0 }
    memo { '大人ネイビー色' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate6_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item21, class: Item do
    id      { 21 }
    user_id { other.id }
    cordinate_id { cordinate6.id }
    super_item { 2 }
    season { 0 }
    tpo { 1 }
    rating { 4 }
    color { 1 }
    content { 4 }
    memo { 'ホワイト&ブラックサイドライン' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate6_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item22, class: Item do
    id      { 22 }
    user_id { other.id }
    cordinate_id { cordinate6.id }
    super_item { 3 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 2 }
    content { 10 }
    memo { 'コーデを選ばないシューズ' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate6_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item23, class: Item do
    id      { 23 }
    user_id { blockuser.id }
    cordinate_id { cordinate7.id }
    super_item { 0 }
    season { 2 }
    tpo { 0 }
    rating { 4 }
    color { 0 }
    content { 8 }
    memo { 'ベロアブラック!!' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate7_outer.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item24, class: Item do
    id      { 24 }
    user_id { blockuser.id }
    cordinate_id { cordinate7.id }
    super_item { 1 }
    season { 2 }
    tpo { 1 }
    rating { 4 }
    color { 1 }
    content { 0 }
    memo { 'ワンポイントアニマル♪' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate7_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item25, class: Item do
    id      { 25 }
    user_id { blockuser.id }
    cordinate_id { cordinate7.id }
    super_item { 2 }
    season { 2 }
    tpo { 1 }
    rating { 3 }
    color { 0 }
    content { 6 }
    memo { 'コーデに左右されない迷彩♪' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate7_pants.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  factory :item26, class: Item do
    id      { 26 }
    user_id { blockuser.id }
    cordinate_id { cordinate7.id }
    super_item { 3 }
    season { 1 }
    tpo { 1 }
    rating { 3 }
    color { 3 }
    content { 11 }
    memo { '履くのが超楽ちん♪' }
    # sequence(:content) { |n| "これは#{n}個目のアイテムです" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate7_shoes.JPG')) }
    association :cordinate
    user { cordinate.user }
  end

  # testuser用

  factory :item27, class: Item do
    id      { 1 }
    user_id { testuser.id }
    cordinate_id { cordinate9.id }
    super_item { 1 }
    season { 2 }
    tpo { 3 }
    rating { 4 }
    color { 1 }
    content { 3 }
    memo { '差し色グリーンがナイス!' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate1_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
    # picture { 1 }
  end

  factory :item28, class: Item do
    id      { 1 }
    user_id { testuser.id }
    cordinate_id { cordinate9.id }
    super_item { 1 }
    season { 2 }
    tpo { 3 }
    rating { 4 }
    color { 1 }
    content { 3 }
    memo { '差し色グリーンがナイス!' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/cordinate1_tops.JPG')) }
    association :cordinate
    user { cordinate.user }
    # picture { 1 }
  end

  # enum super_item: %w( 0outer 1tops 2bottoms 3shoes )
  # enum season: %w( 0spring 1summer 2autmun 3winter )
  # enum tpo: %w(0dating 1relax 2sports 3town 4work)
  # enum rating: %w(1 2 3 4 5)
  # enum content: %w(0tshirts 1shirts 2poloshirts 3parker 4sweat 5sweater 6pants 7denimpants 8jacket 9coat 10sneaker 11loafer 12leather_shoes 13boots 14business 15others)
  # enum color: %w(0black 1white 2gray 3red 4navy 5light-blue 6yellow 7green 8orenge 9olive 10neon 11border 12patternned 13denim 14othercolor)
  # enum content: %w(0tshirts 1shirts 2poloshirts 3parker 4sweat 5sweater 6pants 7denimpants 8jacket 9coat 10sneaker 11loafer 12leather_shoes 13boots 14business 15others)

  #   Traceback (most recent call last):
  #         2: from (irb):13
  #         1: from (irb):13:in `rescue in irb_binding'
  # ActiveRecord::RecordNotUnique (Mysql2::Error: Duplicate entry '6' for key 'PRIMARY': INSERT INTO `items` (`id`, `user_id`, `cordinate_id`, `super_item`, `season`, `tpo`, `rating`, `color`, `content`, `memo`, `picture`, `created_at`, `updated_at`) VALUES (6, 1, 3, 2, 1, 1, 3, 2, 10, 'コーデを選ばないシューズ', 'cordinate3_shoes.JPG', '2021-01-31 06:33:29', '2021-01-31 06:33:29'))
  # irb(main):014:0>

  # FactoryBot.create(:owner)

  # rails db:migrate:reset RAILS_ENV=test
end
