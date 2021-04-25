
# rspec ./spec/models/cordinate_spec.rb
#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cordinate, type: :model do

  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }
  let!(:item1) {build(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}  
  let!(:cordinate1) {build(:cordinate1, user_id: admin.id)}
  let!(:cordinate2) {build(:cordinate2, user_id: admin.id)}

  let!(:item1) {build(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let!(:item2) {build(:item2, user_id: admin.id, cordinate_id: cordinate1.id)}

  let!(:comment1)  {build(:comment1, user_id: user.id, cordinate_id: cordinate1.id)}
  let!(:comment2)  {build(:comment2, user_id: user.id, cordinate_id: cordinate1.id)}
  
  let!(:likecordiante1) {build(:likecordinate1, user_id: user.id, cordinate_id: cordinate1.id)}
  
  
  describe "存在性チェック" do
    #SCCESS!!
    it "buildデータが有効であること " do
      expect(cordinate1).to be_valid
    end

#SCCESS!!
 it "seasonがなければ無効な状態であること" do
  cordinate1.season = nil
  cordinate1.valid?
  expect(cordinate1.errors[:season]).to include("を入力してください")
end

#SCCESS!!
 it "tpoがなければ無効な状態であること" do
  cordinate1.tpo = nil
  cordinate1.valid?
  expect(cordinate1.errors[:tpo]).to include("を入力してください")
end

 # ratingがなければ無効な状態であること
 #FAILER!!! デフォルトの設定があるからか？？
 it "is invalid without a rating" do
  cordinate1.rating = nil
  cordinate1.valid?
  expect(cordinate1.errors[:rating]).to include("を入力してください")
end

  #SCCESS!!
  describe "メモの長さ" do
    
    it "141文字のメモは無効であること" do
      cordinate1.memo = "あ" * 141
      cordinate1.valid?
      expect(cordinate1.errors[:memo]).to include("は140文字以内で入力してください")
    end

    it "140文字のメモは有効であること" do
      cordinate1.title = "あ" * 140
      expect(cordinate1).to be_valid
    end
  end
  
  describe "削除の依存関係" do

before do
  cordinate1.save
end
    
    it "削除すると、紐づくcommentも全て削除されること" do
      cordinate1.save
      comment1.save  
      comment2.save
      expect do
        delete cordinate_delete_path(cordinate1)
      end.to change(Comment.all, :count).by(-2)
    end
    
    it "削除すると、紐づくlikecordinateも全て削除されること" do
      likecordiante1.save
      expect do
        delete cordinate_delete_path(cordinate1)
      end.to change(Likecordinate.all, :count).by(-1)
    end       
end
end
end



# cordinate_delete_path	DELETE	/users/:user_id/cordinates/:id(.:format)	
# cordinates#destroy
