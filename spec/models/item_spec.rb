# rspec ./spec/models/item_spec.rb

# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Item, type: :model do


  let!(:admin) { FactoryBot.create(:admin) }  

  #otherをuserに変えて使用している。
  let!(:user) { FactoryBot.build(:user) }
  let!(:blockuser) { FactoryBot.build(:blockuser) }
  
  let!(:cordinate1) {FactoryBot.build(:cordinate1, user_id: admin.id)}
  let!(:cordinate2) {FactoryBot.build(:cordinate2, user_id: admin.id)}
  let!(:cordinate4) {FactoryBot.build(:cordinate4, user_id: user.id)}
  let!(:cordinate5) {FactoryBot.build(:cordinate5, user_id: user.id)}

  let!(:item1) {FactoryBot.build(:item1, user_id: admin.id, cordinate_id: cordinate4.id)}
  let!(:item2) {FactoryBot.build(:item2, user_id: admin.id, cordinate_id: cordinate4.id)}

  let!(:comment1) { FactoryBot.build(:comment1, user_id: user.id, cordinate_id: cordinate1.id)}
  let!(:comment2) { FactoryBot.build(:comment2, user_id: user.id, cordinate_id: cordinate2.id)}
  let!(:likecordiante1){FactoryBot.build(:likecordinate1, user_id: user.id, cordinate_id: cordinate1.id)}
  let!(:likecordiante2){FactoryBot.build(:likecordinate2, user_id: user.id, cordinate_id: cordinate2.id)}
  
  let!(:bloc1){FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)}

# describe '存在性チェック' do

#   it 'buildデータが有効であること' do
#     expect(item1).to be_valid
#   end

#   it 'user_idがなければ無効な状態であること' do    
#     item1.user_id = nil
#     item1.valid?
#     expect(item1.errors[:user_id]).to include('を入力してください')    
#   end

#   # テストに含めていないカラム
#   # t.integer "cordinate_id"
#   # t.integer "storage"
#   # t.text "memo"
#   # t.string "picture"

#   it 'super_itemがなければ無効な状態であること' do
#     item1.super_item = nil
#     item1.valid?
#     expect(item1.errors[:super_item]).to include('を入力してください')
#   end

#   it 'seasonがなければ無効な状態であること' do
#     item1.season = nil
#     item1.valid?
#     expect(item1.errors[:season]).to include('を入力してください')
#   end

#   it 'tpoがなければ無効な状態であること' do
#     item1.tpo = nil
#     item1.valid?
#     expect(item1.errors[:tpo]).to include('を入力してください')
#   end
 
#   # it 'ratingがなければ無効な状態であること' do
#   #   item1.rating = nil
#   #   item1.valid?
#   #   expect(item1.errors[:rating]).to include('を入力してください')
#   # end
 
#   # it 'contentがなければ無効な状態であること' do
#   #   item1.content = nil
#   #   item1.valid?
#   #   expect(item1.errors[:content]).to include('を入力してください')
#   # end

#   it 'colorがなければ無効な状態であること' do
#     item1.color = nil
#     item1.valid?
#     expect(item1.errors[:color]).to include('を入力してください')
#   end
# end


# describe 'メモの長さ' do
#   it '141文字の内容は無効であること' do
#     item1.memo = 'あ' * 141
#     item1.valid?
#     expect(item1).to_not be_valid
#     # expect(item1.errors[:content]).to include('は140文字以内で入力してください')
#   end
  
#   it '140文字の内容は有効であること' do
#     item1.memo = 'あ' * 140           
#     expect(item1).to be_valid
#   end
# end

describe '画像のアップロード' do

  it '画像なしでも有効であること' do                        
    item1.picture = nil
    expect(item1).to be_valid
  end

  fit '画像なしの場合、デフォルト画像が設定されること' do    
    item1.picture = nil
    expect(item1.picture.url).to eq '/default/no_image.png'
  end

  it 'デフォルト画像以外の画像を設定できること' do
    # image_path = Rails.root.join("public/default/default_user.png")
    # item = FactoryBot.build(:item, manufacturer: manufacturer, category: category, image: File.open(image_path))
    # item.save
    expect(item.image.url).to eq "/uploads/item/image/#{item.id}/default_user.png"
  end
end
end

# 検索
# describe 'search' do
#   # 紐づくタグと部分一致する文言があればヒットすること
#   it 'can search in related tags' do
#     2.times { FactoryBot.create(:item) }
#     create(:review, item: Item.first,  tag_list: '美味しい')
#     create(:review, item: Item.second, tag_list: '美味しい')
#     expect(Item.search('味し').ids).to eq [Item.first.id, Item.second.id]
#   end

#   # 商品説明と部分一致する文言があればヒットすること
#   it 'can search in its content' do
#     2.times { create(:item, content: 'test') }
#     expect(Item.search('est').ids).to eq [Item.first.id, Item.second.id]
#   end
# end