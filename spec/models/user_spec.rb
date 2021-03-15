# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:admin) { FactoryBot.create(:admin) }
  # otherをuserに変えて使用している。
  let(:user) { FactoryBot.create(:user) }
  let(:blockuser) { FactoryBot.create(:blockuser) }

  let(:cordinate1) { FactoryBot.create(:cordinate1, user_id: admin.id) }
  let(:cordinate2) { FactoryBot.create(:cordinate2, user_id: admin.id) }
  let(:cordinate4) { FactoryBot.create(:cordinate4, user_id: user.id) }
  let(:cordinate5) { FactoryBot.create(:cordinate5, user_id: user.id) }

  let(:item11) { FactoryBot.create(:item11, user_id: user.id, cordinate_id: cordinate4.id) }
  let(:item12) { FactoryBot.create(:item12, user_id: user.id, cordinate_id: cordinate4.id) }

  let(:comment1) { FactoryBot.create(:comment1, user_id: user.id, cordinate_id: cordinate1.id) }
  let(:comment2) { FactoryBot.create(:comment2, user_id: user.id, cordinate_id: cordinate2.id) }
  let(:likecordiante1) { FactoryBot.create(:likecordinate1, user_id: user.id, cordinate_id: cordinate1.id) }
  let(:likecordiante2) { FactoryBot.create(:likecordinate2, user_id: user.id, cordinate_id: cordinate2.id) }

  let(:bloc1) { FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id) }

  # 通知機能の実装

  # 名前、メール、パスワードがあり、有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  # create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  #   t.string "name"
  #   t.string "email"
  #   t.string "password_digest"
  #   t.string "picture"
  #   t.integer "cordinate_id"
  #   t.integer "item_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.boolean "admin", default: false
  #   t.string "activation_digest"
  #   t.boolean "activated", default: false
  #   t.datetime "activated_at"
  #   t.string "remember_digest"
  #   t.string "reset_digest"
  #   t.datetime "reset_sent_at"
  #   t.integer "comment_id"
  #   t.index ["email"], name: "index_users_on_email", unique: true
  # end

  # Validationチェック
  describe 'Validation' do
    # 名前がなければ無効な状態であること
    it 'is invalid without a name' do
      user.name = nil
      user.valid?
      expect(user.name).to be_falsely
    end
    # メールアドレスがなければ無効な状態であること
    it 'is invalid without an email address' do
      user.email = nil
      user.valid?
      expect(user.email).to be_falsely
    end

    # パスワードがなければ無効な状態であること
    it 'is invalid without a password' do
      user.password = nil
      user.valid?
      expect(user.password).to be_falsely
    end
  end

  # 先にuserの重複が引っかからないのか?
  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    user.save
    dupulicate_user = FactoryBot.build(:user, email: user.email)
    dupulicate_user.valid?
    expect(dupulicate_user.errors[:email]).to include('はすでに存在します')
  end

  # メールアドレスは保存前に小文字変換されること
  it 'convert capital letters into email into small' do
    user.email = 'TEST@GMAIL.COM'
    user.save
    expect(user.email).to eq 'test@gmail.com'
  end

  # メールアドレスは規定の正規表現に従うこと
  describe 'email obeys VALID_EMAIL_REGEX' do
    # ドメインのないメールアドレスは無効なこと
    it 'is invalid with no domain' do
      user.email = 'test'
      user.valid?
      expect(user.email).to be_falsely
      # Error文の指定はしていない
      # expect(user.errors[:email]).to include("は不正な値です")
    end

    # ドメインのあるメールアドレスは有効なこと
    it 'is valid with a domain' do
      user.email = 'test@ruby.org'
      expect(user).to be_valid
    end
  end

  # パスワードの正規表現
  describe 'regex of password' do
    # 10文字以上20文字以下で、大文字・小文字・数字を最低1文字含むパスワードは有効であること
    it 'is valid with a password which contains captal and small letters and number' do
      user.password = 'Password12'
      expect(user).to be_valid
    end

    # 大文字を含まないパスワードは無効であること
    it 'is valid with a password which does not contain capital letter' do
      user.password = 'password12'
      user.valid?
      expect(user.password).to be_falsely
      # expect(user.errors[:password]).to include("は半角10~20文字英大文字・小文字・数字をそれぞれ１文字以上含む必要があります")
    end

    # 小文字を含まないパスワードは無効であること
    it 'is valid with a password which does not contain small letter' do
      user.password = 'PASSWORD12'
      user.valid?
      expect(user.password).to be_falsely
      # expect(user.errors[:password]).to include("は半角10~20文字英大文字・小文字・数字をそれぞれ１文字以上含む必要があります")
    end

    # 数字を含まないパスワードは無効であること
    it 'is valid with a password which does not contain number' do
      user.password = 'PASSWORDfail'
      user.valid?
      expect(user.password).to be_falsely
      # expect(user.errors[:password]).to include("は半角10~20文字英大文字・小文字・数字をそれぞれ１文字以上含む必要があります")
    end
  end

  # 名前の長さ
  describe 'length of name' do
    # 21文字の名前は無効であること
    it 'is invalid with a name which has over 21 characters' do
      user.name = 'あ' * 21
      user.valid?
      expect(user.name).to be_falsely
      # expect(user.errors[:name]).to include("は20文字以内で入力してください")
    end

    # 20文字の名前は有効であること
    it 'is valid with a name which has 300 characters' do
      user.name = 'あ' * 20
      expect(user).to be_valid
    end
  end

  # メールアドレスの長さ
  describe 'length of email' do
    # 256文字の名前は無効であること
    it 'is invalid with a email which has over 256 characters' do
      user.email = 'あ' * 256
      user.valid?
      expect(user.email).to be_falsely
      # expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end

    # 255文字の名前は有効であること
    it 'is valid with a email which has 255 characters' do
      domain = '@a.com'
      user.email = 'a' * (255 - domain.length) + domain
      expect(user).to be_valid
    end
  end

  # 画像のアップロード
  describe 'check image upload' do
    # 画像なしでも有効であること
    it 'is valid with no image' do
      user.picture = nil
      expect(user).to be_valid
    end

    # 画像なしの場合、デフォルト画像が設定されること
    it 'has a default image with no image' do
      user.picture = nil
      # user = FactoryBot.build(:testuser, picture: nil)
      expect(user.picture.url).to eq '/default/default_user.png'
    end

    # デフォルト画像以外の画像を設定できること
    it 'can set an image except default image' do
      image_path = Rails.root.join('public/default/guy2.png')
      user.picture = File.open(picture_path)
      # user = FactoryBot.build(:testuser, picture: File.open(picture_path))
      user.save
      expect(user.image.url).to eq "/uploads/user/image/#{user.id}/guy2.png"
    end

    # 5MBを超える画像はアップロードできないこと
    it 'can not upload an image over 5MB' do
      image_path = Rails.root.join('public/default/over_5MB.png')
      user.picture = File.open(image_path)
      # user = FactoryBot.build(:testuser, image: File.open(image_path))
      user.valid?
      expect(user.errors[:image]).to include 'は5MB以下にする必要があります'
    end
  end

  # 削除の依存関係
  describe 'dependent: destoy' do
    # 削除すると、紐づくフォローも全て削除されること
    it 'destroys all follows when deleted' do
      user.follow(admin)
      user.follow(blockuser)
      expect { user.destroy }.to change(user.following, :count).by(-2)
    end

    # 削除すると、紐づくフォロワーも全て削除されること
    it 'destroys all followers when deleted' do
      user.follow(admin)
      user.follow(blockuser)
      expect { user.destroy }.to change(admin.followers, :count).by(-1).and change(blockuser.followers, :count).by(-1)
    end

    # 削除すると、紐づくアイテムも全て削除されること
    it 'destroys all items when deleted' do
      expect { user.destroy }.to change(user.items, :count).by(-2)
    end

    # 削除すると、紐づくコーディネートも全て削除されること
    it 'destroys all cordinates when deleted' do
      expect { user.destroy }.to change(user.cordinates, :count).by(-2)
    end

    # 削除すると、紐づくコメントも全て削除されること
    it 'destroys all comments when deleted' do
      expect { user.destroy }.to change(user.comments, :count).by(-2)
    end

    # 削除すると、紐づくlikecordinateも全て削除されること
    it 'destroys all likecordinates when deleted' do
      expect { user.destroy }.to change(user.likecordinates, :count).by(-2)
    end

    # ここから、他のテストと併用して記述する

    # 削除すると、紐づく通知も全て削除されること
    it 'destroys all follows when deleted' do
      comment.create_notice_comment_like(user1)
      comment.create_notice_comment_like(user2)
      expect { user.destroy }.to change(user.passive_notices, :count).by(-2)
    end

    # 削除すると、紐づくブロックも全て削除されること
    it 'destroys all blocks when deleted' do
      user.block(admin)
      user.block(blockuser)
      expect { user.destroy }.to change(user.blocking, :count).by(-2)
    end
  end

  # bcryptによるダイジェスト生成がうまくいくこと
  it 'can generate digest successfully by bcrypt' do
    expect(User.digest('test')).to include('$2a')
  end

  # base64によるトークン生成がうまくいくこと
  it 'can generate a token successfully by base64' do
    expect(User.new_token.length).to eq 22
  end

  # remember_digestにトークンが保存されること
  it 'saves remember digest successfully' do
    expect(user.remember_digest).to eq nil
    user.remember
    expect(user.remember_digest).to include('$2a')
  end

  # autenticated?メソッドでダイジェストと適切に照合ができること
  it 'can match with the result of authenticated?' do
    expect(user.authenticated?(:password, 'Password12')).to be_truthy
  end

  # パスワード再設定のダイジェストを設定できること,reset_digestはちゃんとコマンドは定義されてるのか？
  it 'can set password reset digest successfully' do
    expect(user.reset_digest).to eq nil
    user.create_reset_digest
    expect(user.reset_digest).to include('$2a')
    # 複数回のリセットも問題ないこと
    user.create_reset_digest
    expect(user.reset_digest).to include('$2a')
  end

  # パスワード再設定の設定時に時刻が設定できること
  it 'can set password reset digest sent time successfully' do
    expect(user.reset_sent_at).to eq nil
    current_time = Time.zone.now
    sleep(1)
    user.create_reset_digest

    expect(user.reset_sent_at >= current_time).to be_truthy
  end

  # パスワードの再設定期限
  describe 'time limit of password reset' do
    # 2時間以内ならfalseとなること
    it 'returns false password within 2 hours' do
      user.reset_sent_at = Time.zone.now - 2.hours + 1.second
      expect(user.password_reset_expired?).to be_falsy
    end

    # 2時間を超えるならtrueできること
    it 'returns true password within 2 hours' do
      user.reset_sent_at = Time.zone.now - 2.hours
      expect(user.password_reset_expired?).to be_truthy
    end
  end

  # ユーザーのremember digestを破棄できること
  it 'can delete remember digest' do
    user.remember_digest = 'test'
    user.save
    user.forget
    expect(User.find(user.id).remember_digest).to eq nil
  end

  # ここから

  # フォロー
  describe 'follow' do
    # うまくフォローできること
    it 'can follow successfully' do
      expect { user.follow(admin) }.to change(admin.followers, :count).by(1)
    end

    # うまくアンフォローできること
    it 'can unfollow successfully' do
      user.follow(admin)
      expect { user.unfollow(admin) }.to change(admin.followers, :count).by(-1)
    end

    # フォローしていたらtrue、フォローしていないときはfalseを返すこと
    it 'returns true if he is follower, not if false' do
      user.follow(admin)
      expect(user.following?(admin)).to be_truthy
      expect(user.following?(blockuser)).to be_falsy
    end
  end

  # ブロック
  describe 'block' do
    # うまくブロックできること
    it 'can block successfully' do
      expect { user.block(blockuser) }.to change(user.blocking, :count).by(1)
    end

    # うまくアンブロックできること
    it 'can unblock successfully' do
      user.block(blockuser)
      expect { user.unblock(blockuser) }.to change(user.blocking, :count).by(-1)
    end

    # ブロックしていたらtrue、ブロックしていないときはfalseを返すこと
    it 'returns true if he is blocked, not if false' do
      user.block(blockuser)
      expect(user.blocking?(blockuser)).to be_truthy
      expect(user.blocking?(admin)).to be_falsy
    end
  end

  # 通知
  describe 'notice' do
    context 'action: follow' do
      # 初回フォローで通知が作成されること
      it 'can create notice if you have been followed first time' do
        expect { user.create_notice_follow(user1) }.to change(user.passive_notices, :count).by(1)
      end

      # 過去にフォローしたことがある場合、通知は作成されずnilを返すこと
      it 'can not create notice if you have been already followed' do
        expect { user.create_notice_follow(user1) }.to change(user.passive_notices, :count).by(1)
        expect(user.create_notice_follow(user1)).to eq nil
      end
    end
  end

  # アカウント有効化ダイジェストが作成されること
  it 'generates digest of account activation' do
    expect(user.activation_digest).to include('$2a$')
  end

  # ブロックまたはブロックされているユーザのidを返す
  it 'returns blocked or blocking user-ids' do
    user.block user1
    user1.block user2
    expect(user1.block_ids.count).to eq 2
    expect(user1.block_ids.include?(user.id)).to eq true
    expect(user1.block_ids.include?(user2.id)).to eq true
  end

  # 作成のコールバック
  describe 'after_create' do
    # 管理者ユーザの作成時は、メッセージが作成されないこと
    it "doesn't create messages if user is an admin" do
      a = FactoryBot.create(:admin)
      expect(a.messages.count).to eq 0
    end

    # 一般ユーザの作成時は、初期メッセージが2件送信されること
    it 'can create messages if user is not an admin' do
      expect { FactoryBot.create(:user) }.to change(user.messages, :count).by(2)
    end
  end
end
