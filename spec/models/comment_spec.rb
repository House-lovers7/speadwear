#rspec ./spec/models/comment_spec.rb
#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do


  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }  
  let!(:item1) {build(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}  
  let!(:cordinate1) {create(:cordinate1, user_id: admin.id)}
  let!(:cordinate2) {build(:cordinate2, user_id: admin.id)}

  let!(:item1) {build(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let!(:item2) {build(:item2, user_id: admin.id, cordinate_id: cordinate1.id)}

  let!(:comment1)  {build(:comment1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let!(:comment2)  {build(:comment2, user_id: admin.id, cordinate_id: cordinate1.id)}
  
  let!(:likecordiante1) {build(:likecordinate1, user_id: user.id, cordinate_id: cordinate1.id)}
  

  #  let(:self_comment) { FactoryBot.create(:comment, : cordinate_id: user.cordinate.id , user_id: user.id) }

  it "有効なファクトリを持つこと" do
  expect(comment1).to be_valid
end

  # user_id、cordinate_id、commentの存在

  describe "presence of user_id, cordinate_id, content" do
  #SUCCESS!!
    it "user_id、cordinate_id, comemntの全てがあれば有効であること" do      
      expect(comment1).to be_valid
    end

    #SUCCESS!!
    it "user_idがなければ無効な状態であること" do   
      comment1.user_id = nil            
      comment1.valid?
      expect(comment1.errors[:user_id]).to include("を入力してください")                            
    end

    #SUCCESS!!
    it "cordinate_idがなければ無効な状態であること" do
      comment1.cordinate_id = nil                  
      comment1.valid?
      expect(comment1.errors[:cordinate_id]).to include("を入力してください")
    end
   
    #SUCCESS!!
    it "commentがなければ無効な状態であること" do
      comment1.comment = nil                  
      comment1.valid?
      expect(comment1.errors[:comment]).to include("を入力してください")
    end
  end

  describe "コメントの長さ" do
    #SUCCESS!!
    it "141文字のコメントは無効であること" do
      comment1.comment = "あ" * 141
      comment1.valid?
      expect(comment1.errors[:comment]).to include("は140文字以内で入力してください")                              
    end

    #SUCCESS!!
    it "140文字のコメントは有効であること" do
      comment1.comment = "あ" * 140
      expect(comment1).to be_valid
    end
  end


   #FAILER!!
  describe "削除の依存関係" do
    fit "コメントを消せば、紐づくいいね!と通知が全て削除されること" do
      2.times { FactoryBot.create(:comment1) }
      Comment.create(comment_id: comment.id, user_id: User.first.id)
      Comment.create(comment_id: comment.id, user_id: User.second.id)
      #通知処理のアクション、Notification向け？？
      # comment.create_notice_comment(User.first)
      # comment.create_notice_comment(User.second)
      expect { comment.destroy }.to change { Comment.count }.by(-2).and change { Notification.count }.by(-2)
    end
  end

  #FAILER!!
  describe "通知" do
    context "action: comment" do     
      it "自分のレビューにコメントしても、通知は作成されずnilを返すこと" do
        expect(self_comment.create_notice_comment(user)).to eq nil
        expect { self_comment.create_notice_comment(user) }.to change(Notice.all, :count).by(0)
      end
    
      it "他人のレビューへのコメントでは毎回通知が作成されること" do
        other_user = FactoryBot.create(:user)
        comment1 = FactoryBot.create(:comment, review: self_review, user: other_user)
        expect { comment1.create_notice_comment(other_user) }.to change(Notice.all, :count).by(1)
        comment2 = FactoryBot.create(:comment, review: self_review, user: other_user)
        expect { comment2.create_notice_comment(other_user) }.to change(Notice.all, :count).by(1)
      end
    end
    
      it "他人のコメントへのいいね！では通知が作成され、かつ一度だけしか作成されないこと" do
        other_user = FactoryBot.create(:user)
        other_comment = FactoryBot.create(:comment, user: other_user)
        CommentLike.create!(user_id: user.id, comment_id: other_comment.id)
        expect { other_comment.create_notice_comment_like(user) }.to change(Notice.all, :count).by(1)

        # 削除
        expect { user.comment_likes.destroy_all }.to change(user.comment_likes, :count).by(-1)

        # 再作成
        CommentLike.create!(user_id: user.id, comment_id: other_comment.id)
        expect { other_comment.create_notice_comment_like(user) }.to change(Notice.all, :count).by(0)
      end
    end
  end
