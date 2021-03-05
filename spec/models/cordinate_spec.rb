require 'rails_helper'

RSpec.describe Cordinate, type: :model do

  let(:user) { FactoryBot.create(:testuser) }
  let(:cordinate9) {FactoryBot.create(:cordinate9, user_id: user.id)}
  let(:cordinate10) {FactoryBot.create(:cordinate10, user_id: user.id)}

  let(:comment9) = {FactoryBot.create(:comment1, user_id: other.id, cordinate_id: cordinate9.id)}
  let(:comment10) = {FactoryBot.create(:comment2, user_id: other.id, cordinate_id: cordinate9.id)}

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect { FactoryBot.create(:cordinate9) }.to change(Cordinate.all, :count).by(1)
  end

  # 存在性チェック
  describe "test of presence" do
    before do
      @valid_cordinate = FactoryBot.build(:cordinate9, user_id: user.id, cordinate_id: id)
    end

    # buildデータが有効であること
    it "is valid with a user_id and item_id, content " do
      expect(@valid_cordinate).to be_valid
    end

 # seasonがなければ無効な状態であること
 it "is invalid without a season" do
  @valid_cordinate.season = nil
  @valid_cordinate.valid?
  expect(@valid_cordinate.errors[:season]).to include("を入力してください")
end

 # tpoがなければ無効な状態であること
 it "is invalid without a tpo" do
  @valid_cordinate.tpo = nil
  @valid_cordinate.valid?
  expect(@valid_cordinate.errors[:tpo]).to include("を入力してください")
end

 # ratingがなければ無効な状態であること
 it "is invalid without a rating" do
  @valid_cordinate.rating = nil
  @valid_cordinate.valid?
  expect(@valid_cordinate.errors[:rating]).to include("を入力してください")
end

  # メモの長さ
  describe "length of memo" do
    # 141文字のメモは無効であること
    it "is invalid with a title which has over 51 characters" do
      cordinate.memo = "あ" * 141
      cordinate.valid?
      expect(cordinate.errors[:memo]).to include("は140文字以内で入力してください")
    end

    # 140文字のメモは有効であること
    it "is valid with a title which has 140 characters" do
      cordinate.title = "あ" * 140
      expect(cordinate).to be_valid
    end
  end

#ここから

  # 削除の依存関係
  describe "dependent: destoy" do
    # 削除すると、紐づくcommentも全て削除されること
    it "destroys all eaten_item when deleted" do
      expect { cordinarte.destroy }.to change(Comment.all, cordinate_id: cordinate9.id :count).by(-2)
    end

    # 削除すると、紐づくlikecordinateも全て削除されること
    it "destroys all likecordinate when deleted" do
      2.times { FactoryBot.create(:likecordinate, cordinate_id: cordinate.id ) }
      expect { Cordinate.destroy }.to change(Likecordinagte.all, :count).by(-2)
    end
  end


end
