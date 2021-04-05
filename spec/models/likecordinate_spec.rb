# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe Likecordinate, type: :model do
#   # let(:user) { FactoryBot.create(:user) }
#   # let(:likecordinate) { FactoryBot.create(:likecordinate) }

#   # 有効なファクトリを持つこと
#   # it "has a valid factory" do
#   #   expect { FactoryBot.create(:likecordinate)}.to change(Likecordinate).all, :count).by(1)
#   # end

#   # user_id、cordinate_idの存在
#   # describe "presence of user_id, cordinate_id" do
#   #   # user_id、comment_idの両方があれば有効な状態であること
#   #   it "is valid with a user_id and cordinate_id" do
#   #     likecordinate = Likecordinate.new(user_id: user.id, cordinate_id: cordinate.id)
#   #     expect(likecordinate).to be_valid
#   #   end

#   # user_idがなければ無効な状態であること
#   it 'is invalid without a user_id' do
#     likecordinate = Likecordinate.new(user_id: nil, cordinate_id: cordinate.id)
#     likecordinate.valid?
#     expect(likecordinate.errors[:user_id]).to include('を入力してください')
#   end

#   # cordinate_idがなければ無効な状態であること
#   it 'is invalid without a cordinate_id' do
#     likecordinate = Likecordinate.new(user_id: user.id, cordinate_id: nil)
#     likecordinate.valid?
#     expect(likecordinate.errors[:cordinate_id]).to include('を入力してください')
#   end
# end

# # # 同じコメントを2回以上いいね！できないこと
# # it "can not create two likecordinates for same comment" do
# #   Likecordinate.create(user_id: user.id, cordinate_id: cordinate.id)
# #   likecordinate = Likecordinate.new(user_id: user.id, cordinate_id: cordinate.id)
# #   likecordinate.valid?
# #   expect(likecordinate.errors[:cordinate_id]).to include("はすでに存在します")
# # end

# # 作成と削除ができること
# # it "can create and destroy" do
# #   expect { FactoryBot.create(:likecordinate) }.to change(Likecordinate.all, :count).by(1)
# #   expect { Likecordinate.first.destroy }.to change(Likecordinate.all, :count).by(-1)
# # end
