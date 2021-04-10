# rspec ./spec/models/user_spec.rb

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # otherをuserに変えて使用している。
   let!(:user) { build(:user) }
   let!(:admin) { build(:admin) }
   let!(:other) { build(:other) }
   let!(:blockuser) { build(:blockuser) }   

   let(:relationship) { user.active_relationships.build(id: 1, follower_id: admin.id, followed_id: other.id) }
   
  #  let!(:relationship1) { user.active_relationships.build(followed_id: other.id) }
   
  #  let!(:relationship1) { build(:relationship1, follower_id: admin.id, followed_id: other.id)}
  #  let!(:relationship2) { build(:relationship2, follower_id: other.id, followed_id: blockuser.id)}
  #  let!(:relationship3) { build(:relationship3, follower_id: other.id, followed_id: blockuser.id)}

  # let(:cordinate1) { FactoryBot.build(:cordinate1, user_id: admin.id) }
  # let(:cordinate2) { FactoryBot.build(:cordinate2, user_id: admin.id) }
  # let(:cordinate4) { FactoryBot.build(:cordinate4, user_id: user.id) }
  # let(:cordinate5) { FactoryBot.build(:cordinate5, user_id: user.id) }

  # let(:item11) do
  #   FactoryBot.build(:item11, user_id: user.id, cordinate_id: cordinate4.id)
  # end
  # let(:item12) do
  #   FactoryBot.build(:item12, user_id: user.id, cordinate_id: cordinate4.id)
  # end

  # let(:comment1) do
  #   FactoryBot.build(:comment1, user_id: user.id, cordinate_id: cordinate1.id)
  # end
  # let(:comment2) do
  #   FactoryBot.build(:comment2, user_id: user.id, cordinate_id: cordinate2.id)
  # end
  # let(:likecordiante1) do
  #   FactoryBot.build(:likecordinate1, user_id: user.id,
  #                                      cordinate_id: cordinate1.id)
  # end
  # let(:likecordiante2) do
  #   FactoryBot.build(:likecordinate2, user_id: user.id,
  #                                      cordinate_id: cordinate2.id)
  # end

  # let(:block1) do
  #   FactoryBot.build(:block1, blocker_id: admin.id, blocked_id: blockuser.id)
  # end

  # 通知機能の実装

   
  it '名前、メール、パスワードがあり、有効なファクトリを持つこと' do    
    expect(user).to be_valid
  end
  
  describe 'Validation' do
     

    fit { is_expected.to validate_presence_of :name }

    it '名前がなければ無効な状態であること' do      
       user.name = nil
      user.valid?      
      expect(user.errors[:name]).to include("を入力してください")
    end
     
    it 'メールアドレスがなければ無効な状態であること' do
      user.email = nil
      user.valid?      
      expect(user.errors[:email]).to include("を入力してください")
    end

     
    it 'パスワードがなければ無効な状態であること' do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end
  
  it '重複したメールアドレスなら無効な状態であること' do
    user.save
    dupulicate_user = FactoryBot.build(:user, email: user.email)
    dupulicate_user.valid?
    expect(dupulicate_user.errors[:email]).to include('はすでに存在します')
  end

   
  it 'メールアドレスは保存前に小文字変換されること' do
    user.email = 'TEST@GMAIL.COM'
    user.save
    expect(user.email).to eq 'test@gmail.com'
  end

  describe 'メールアドレスは規定の正規表現に従うこと' do
    
    it 'ドメインのないメールアドレスは無効なこと' do
      user.email = 'test'
      user.valid?      
      expect(user.errors[:email]).to include("は不正な値です")
    end
     
    it 'ドメインのあるメールアドレスは有効なこと' do
      user.email = 'test@ruby.org'
      expect(user).to be_valid
    end
  end

   
  describe 'パスワードの正規表現' do     
    it '10文字以上20文字以下で、大文字・小文字・数字を最低1文字含むパスワードは有効であること' do
      user.password = 'Password12'
      expect(user).to be_valid
    end

  end
  
  describe '名前の長さ' do
     
    it '21文字の名前は無効であること' do
      user.name = 'あ' * 21
      user.valid?      
      expect(user.errors[:name]).to include("は20文字以内で入力してください")
    end     
    
    it '20文字の名前は有効であること' do
      user.name = 'あ' * 20
      expect(user).to be_valid
    end
  end

  
  describe 'メールアドレスの長さ' do    
    it '256文字の名前は無効であること' do
      user.email = 'あ' * 256
      user.valid?      
      expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end
     
    it '255文字の名前は有効であること' do
      domain = '@a.com'
      user.email = 'a' * (255 - domain.length) + domain
      expect(user).to be_valid
    end
  end
  
  describe ' 画像のアップロード' do

    it '画像なしでも有効であること' do
      user.picture = nil
      expect(user).to be_valid
    end
     
    it '画像なしの場合、デフォルト画像が設定されること' do
      user.picture = nil      
      expect(user.picture.url).to eq '/default_user.png'
    end
    
    it 'デフォルト画像以外の画像を設定できること' do
      image_path = Rails.root.join('public/default/guy2.png')
      user.picture = File.open(fixture_path)   
      user.save
      expect(user.image.url).to eq "/uploads/user/image/#{user.id}/guy2.png"
    end
     
    it '5MBを超える画像はアップロードできないこと' do
      image_path = Rails.root.join('public/default/over_5MB.png')
      user.picture = File.open(image_path)      
      user.valid?
      expect(user.errors[:image]).to include 'は5MB以下にする必要があります'
    end
  end

   
  describe '削除の依存関係' do

    before do
      
      admin = User.create
      other = User.create
      blockuser = User.create

    end

    
    it '削除すると、紐づくフォローも全て削除されること' do
             
      relationship1 = create(:relationship1, follower_id: admin.id, followed_id: other.id)
      relationship2 = create(:relationship2, follower_id: admin.id, followed_id: blockuser.id)
      relationship3 = create(:relationship3, follower_id: other.id, followed_id: blockuser.id)
      
      user.follow(admin)
      user.follow(blockuser)
      
      expect {user.destroy }.to change(user.following, :count).by(-2)
    end
    
    it '削除すると、紐づくフォロワーも全て削除されること' do
      user.follow(admin)
      user.follow(blockuser)
      expect do
        user.destroy
      end.to change(admin.followers,
                    :count).by(-1).and change(blockuser.followers, :count).by(-1)
    end
     
  #   it '削除すると、紐づくアイテムも全て削除されること' do
  #     expect { user.destroy }.to change(user.items, :count).by(-2)
  #   end
    
  #   it '削除すると、紐づくコーディネートも全て削除されること' do
  #     expect { user.destroy }.to change(user.cordinates, :count).by(-2)
  #   end

    
  #   it '削除すると、紐づくコメントも全て削除されること' do
  #     expect { user.destroy }.to change(user.comments, :count).by(-2)
  #   end
     
  #   it '削除すると、紐づくlikecordinateも全て削除されること' do
  #     expect { user.destroy }.to change(user.likecordinates, :count).by(-2)
  #   end

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

   
  it 'bcryptによるダイジェスト生成がうまくいくこと' do
    expect(User.digest('test')).to include('$2a')
  end

   
  it 'base64によるトークン生成がうまくいくこと' do
    expect(User.new_token.length).to eq 22
  end

   
  it 'remember_digestにトークンが保存されること' do
    expect(user.remember_digest).to eq nil
    user.remember
    expect(user.remember_digest).to include('$2a')
  end

   
  it 'autenticated?メソッドでダイジェストと適切に照合ができること' do
    expect(user.authenticated?(:password, 'Password12')).to be_truthy
  end

  it 'パスワード再設定のダイジェストを設定できること' do
    expect(user.reset_digest).to eq nil
    user.create_reset_digest
    expect(user.reset_digest).to include('$2a')
    # 複数回のリセットも問題ないこと
    user.create_reset_digest
    expect(user.reset_digest).to include('$2a')
  end

   
  it 'パスワード再設定の設定時に時刻が設定できること' do
    expect(user.reset_sent_at).to eq nil
    current_time = Time.zone.now
    sleep(1)
    user.create_reset_digest
    expect(user.reset_sent_at >= current_time).to be_truthy
  end

  # パスワードの再設定期限
  describe 'time limit of password reset' do
     
    it '2時間以内ならfalseとなること' do
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

    it "is valid with test data" do
      expect(relationship).to be_valid
    end

    it 'フォローできること' do
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
        expect do
          user.create_notice_follow(user1)
        end.to change(user.passive_notices, :count).by(1)
      end

      # 過去にフォローしたことがある場合、通知は作成されずnilを返すこと
      it 'can not create notice if you have been already followed' do
        expect do
          user.create_notice_follow(user1)
        end.to change(user.passive_notices, :count).by(1)
        expect(user.create_notice_follow(user1)).to eq nil
      end
    end
  end

  
  it 'アカウント有効化ダイジェストが作成されること' do
    expect(user.activation_digest).to include('$2a$')
  end


  it 'ブロックまたはブロックされているユーザのidを返す' do
    user.block user1
    user1.block user2
    expect(user1.block_ids.count).to eq 2
    expect(user1.block_ids.include?(user.id)).to eq true
    expect(user1.block_ids.include?(user2.id)).to eq true
  end

  # 
  describe '作成のコールバック' do    
    it "管理者ユーザの作成時は、メッセージが作成されないこと" do
      a = FactoryBot.create(:admin)
      expect(a.messages.count).to eq 0
    end

    # 一般ユーザの作成時は、初期メッセージが2件送信されること
    it 'can create messages if user is not an admin' do
      expect(user).to change(user.messages, :count).by(2)
    end
  end
end