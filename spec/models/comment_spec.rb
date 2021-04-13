#rspec ./spec/models/comment_spec.rb

require 'rails_helper'


RSpec.describe Comment, type: :model do

  let!(:user) { build(:user) }
  let!(:admin) { build(:admin) }
  let!(:other) { build(:other) }
  let!(:blockuser) { build(:blockuser) }
  
  let!(:item1) {create(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let!(:item2) {create(:item2, user_id: admin.id, cordinate_id: cordinate2.id)}

  let(:cordinate1) { build(:cordinate1, user_id: admin.id) }
  let(:cordinate2) { build(:cordinate2, user_id: admin.id) }
  
  let(:comment1){build(:comment1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let(:comment2){build(:comment1, user_id: other.id, cordinate_id: cordinate1.id)}
  

  # 自分で自分のコーディネートにコメントしているデモデータ
   let(:self_comment) { FactoryBot.create(:comment, : cordinate_id: user.cordinate.id , user_id: user.id) }

# 有効なファクトリを持つこと
it "has a valid factory" do
  expect { FactoryBot.create(:comment) }.to change(Comment.all, :count).by(1)
end

  # user_id、cordinate_id、commentの存在

  describe "presence of user_id, cordinate_id, content" do
    # user_id、cordinate_id, comemntの全てがあれば有効な状態であること
    it "is valid with a user_id and cordinate_id, content" do
      comment = Comment.new(user_id: user.id, cordinate_id: cordinate.id, comment: "test")
      expect(comment).to be_valid
    end

    # user_idがなければ無効な状態であること
    it "is invalid without a user_id" do
      comment = Comment.new(user_id: nil, cordinate_id: cordinate.id, comment: "test")
      comment.valid?
      expect(comment.errors[:user_id]).to include("を入力してください")
    end

    # cordinate_idがなければ無効な状態であること
    it "is invalid without a cordinate_id" do
      comment = Comment.new(user_id: user.id, cordinate_id: nil, comment: "test")
      comment.valid?
      expect(comment.errors[:cordinate_id]).to include("を入力してください")
    end

    # commentがなければ無効な状態であること
    it "is invalid without a comment" do
      comment = Comment.new(user_id: user.id, cordinate_id: cordinate.id, comment: nil)
      comment.valid?
      expect(comment.errors[:comment]).to include("を入力してください")
    end
  end

  # コメントの長さ
  describe "length of comment" do
    # 141文字のコメントは無効であること
    it "is invalid with a comment which has over 141 characters" do
      comment.content = "あ" * 141
      comment.valid?
      expect(comment.errors[:comment]).to include("は140文字以内で入力してください")
    end

    # 140文字のコメントは有効であること
    it "is valid with a comment which has 140 characters" do
      comment.comment = "あ" * 140
      expect(comment).to be_valid
    end
  end

  # 削除の依存関係
  describe "dependent: destroy" do
    # コメントを消せば、紐づくいいね!と通知が全て削除されること
    it "destroys comment and notice which has same user_id when deleted" do
      2.times { FactoryBot.create(:user) }
      Comment.create(comment_id: comment.id, user_id: User.first.id)
      Comment.create(comment_id: comment.id, user_id: User.second.id)
      #通知処理のアクション、Notification向け？？
      # comment.create_notice_comment(User.first)
      # comment.create_notice_comment(User.second)
      expect { comment.destroy }.to change { Comment.count }.by(-2).and change { Notification.count }.by(-2)
    end
  end


  # 通知
  describe "notice" do
    context "action: comment" do
      # 自分のレビューにコメントしても、通知は作成されずnilを返すこと
      it "can not create notice when commented by yourself" do
        expect(self_comment.create_notice_comment(user)).to eq nil
        expect { self_comment.create_notice_comment(user) }.to change(Notice.all, :count).by(0)
      end

      # 他人のレビューへのコメントでは毎回通知が作成されること
      it "can create notice when comented by others" do
        other_user = FactoryBot.create(:user)
        comment1 = FactoryBot.create(:comment, review: self_review, user: other_user)
        expect { comment1.create_notice_comment(other_user) }.to change(Notice.all, :count).by(1)
        comment2 = FactoryBot.create(:comment, review: self_review, user: other_user)
        expect { comment2.create_notice_comment(other_user) }.to change(Notice.all, :count).by(1)
      end
    end


      # 他人のコメントへのいいね！では通知が作成され、かつ一度だけしか作成されないこと
      it "can create notice only once when coment_liked by others" do
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
end



  # create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  #   t.string "comment"
  #   t.integer "user_id"
  #   t.integer "cordinate_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["cordinate_id"], name: "index_comments_on_cordinate_id"
  #   t.index ["user_id", "cordinate_id"], name: "index_comments_on_user_id_and_cordinate_id", unique: true
  #   t.index ["user_id"], name: "index_comments_on_user_id"
  # endx
