# # frozen_string_literal: true

# require 'rails_helper'
# require 'cancan/matchers'

# RSpec.describe Item, type: :model do


# let(:admin) { FactoryBot.create(:admin) }  
# #otherをuserに変えて使用している。
#   let(:user) { FactoryBot.create(:user) }
#   let(:blockuser) { FactoryBot.create(:blockuser) }
  
#   let(:cordinate1) {FactoryBot.create(:cordinate1, user_id: admin.id)}
#   let(:cordinate2) {FactoryBot.create(:cordinate2, user_id: admin.id)}
#   let(:cordinate4) {FactoryBot.create(:cordinate4, user_id: user.id)}
#   let(:cordinate5) {FactoryBot.create(:cordinate5, user_id: user.id)}

#   let(:item1) {FactoryBot.create(:item1, user_id: user.id, cordinate_id: cordinate4.id)}
#   let(:item2) {FactoryBot.create(:item2, user_id: user.id, cordinate_id: cordinate4.id)}

#   let(:comment1) { FactoryBot.create(:comment1, user_id: user.id, cordinate_id: cordinate1.id)}
#   let(:comment2) { FactoryBot.create(:comment2, user_id: user.id, cordinate_id: cordinate2.id)}
#   let(:likecordiante1){FactoryBot.create(:likecordinate1, user_id: user.id, cordinate_id: cordinate1.id)}
#   let(:likecordiante2){FactoryBot.create(:likecordinate2, user_id: user.id, cordinate_id: cordinate2.id)}

#   let(:bloc1){FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)}

# # 有効なファクトリを持つこと
# # it "has a valid factory" do
# #   expect { FactoryBot.create(:item) }.to change(Item.all, :count).by(1)
# # end

# # 存在性チェック
# describe 'test of presence' do
#   # before do
#   #    item1 = build(:item, user_id: user_id cordinate_id: cordinate_id super_item: super_item season: season
#   #                               tpo: tpo storage: storage rating: rating color: color content: content memo: memo  and picture: picture)
#   # end

#   # buildデータが有効であること
#   it 'is valid with a user_id cordinate_id super_item season tpo storage rating color content memo  and picture' do
#     expect(item1).to be_valid
#   end

#   # user_idがなければ無効な状態であること
#   it 'is invalid without a user_id' do
#     itme1.user_id = nil
#     item1.valid?
#     expect(item1.errors[:user_id]).to include('を入力してください')
#   end

#   # テストに含めていないカラム
#   # t.integer "cordinate_id"
#   # t.integer "storage"
#   # t.text "memo"
#   # t.string "picture"

#   it 'is invalid without a super_item' do
#     item1.super_item = nil
#     item1.valid?
#     expect(item1.errors[:super_item]).to include('を入力してください')
#   end

#   # seasonがなければ無効な状態であること
#   it 'is invalid without a season' do
#     item1.season = nil
#     item1.valid?
#     expect(item1.errors[:season]).to include('を入力してください')
#   end

#   # tpoがなければ無効な状態であること
#   it 'is invalid without a tpo' do
#     item1.tpo = nil
#     item1.valid?
#     expect(item1.errors[:tpo]).to include('を入力してください')
#   end

#   # ratingがなければ無効な状態であること
#   it 'is invalid without a rating' do
#     item1.rating = nil
#     item1.valid?
#     expect(item1.errors[:rating]).to include('を入力してください')
#   end

#   # contentがなければ無効な状態であること
#   it 'is invalid without a content' do
#     item1.content = nil
#     item1.valid?
#     expect(item1.errors[:content]).to include('を入力してください')
#   end

#   # colorがなければ無効な状態であること
#   it 'is invalid without a color' do
#     item1.color = nil
#     item1.valid?
#     expect(item1.errors[:color]).to include('を入力してください')
#   end
# end

# # メモの長さ
# describe 'length of memo' do
#   # 140文字の内容は無効であること
#   it 'is invalid with a content which has over 141 characters' do
#     item.memo = 'あ' * 141
#     item.valid?
#     expect(item.errors[:content]).to include('は140文字以内で入力してください')
#   end

#   # 140文字の内容は有効であること
#   it 'is valid with a content which has 140 characters' do
#     item.memo = 'あ' * 140
#     expect(item).to be_valid
#   end
# end

# # 画像のアップロード
# describe 'check image upload' do
#   # 画像なしでも有効であること
#   it 'is valid with no image' do
#     item = build(:item, image: nil)
#     expect(item).to be_valid
#   end

#   # 画像なしの場合、デフォルト画像が設定されること
#   it 'has a default image with no image' do
#     # item = FactoryBot.build(:item, manufacturer: manufacturer, category: category, image: nil)
#     expect(item.image.url).to eq '/default/no_image.png'
#   end

#   # デフォルト画像以外の画像を設定できること
#   it 'can set an image except default image' do
#     # image_path = Rails.root.join("public/default/default_user.png")
#     # item = FactoryBot.build(:item, manufacturer: manufacturer, category: category, image: File.open(image_path))
#     # item.save
#     expect(item.image.url).to eq "/uploads/item/image/#{item.id}/default_user.png"
#   end
# end

# # 検索
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
