# rspec ./spec/requests/users_request_spec.rb
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:guestuser) { FactoryBot.create(:guestuser) }

describe '#show' do  
context 'レスポンスが正しいこと' do
  
  before do
    get user_path(admin)
  end  
  #SUCCES!!
  
  it '正常なレスポンスか' do  
    expect(response).to be_success
  end
  
  #SUCCES!!
  it '200レスポンスが返ってきているか？' do    
    expect(response).to have_http_status '200'
  end

end
end
  #SUCCES!!

  context 'ユーザーが存在する場合' do
    before do
      get user_path(admin)
    end    
    #SUCCES!!
    it 'リクエストが成功すること' do    
      expect(response.status).to eq 200
    end
    #SUCCES!!
    it 'ユーザー名が表示されていること' do      
      expect(response.body).to include 'Admin'
    end
  end

  # FAILER!!
  context 'ユーザーが存在しない場合' do
    # get user_path(no_user)
    # subject { -> { get user_path 1 } }
    it { is_expected.to raise_error ActiveRecord::RecordNotFound }
  end
end

describe 'GET #new' do
#SUCCES!!
  it 'リクエストが成功すること' do
    get new_user_path
    expect(response.status).to eq 200
  end
end

describe 'GET #edit' do    
  #SUCCES!!
  it 'リクエストが成功すること' do
    get edit_user_path(admin)
    expect(response.status).to eq 200
  end
  #SUCCES!!
  it 'ユーザー名が表示されていること' do
    get edit_user_path(admin)
    expect(response.body).to include 'Admin'
  end
  #SUCCES!!
  it 'メールアドレスが表示されていること' do
    get edit_user_path(admin)
    expect(response.body).to include 'admin', '@example.com'
  end

describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      #FAILER!!
      it 'リクエストが成功すること' do
        post users_path, params: { user: FactoryBot.attributes_for(:admin) }
        expect(response.status).to eq 302
      end
      #FAILER!!
      it 'ユーザーが登録されること' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:admin) }
        end.to change(User, :count).by(1)
      end
      #FAILER!!
      it 'リダイレクトすること' do
        post users_path, params: { user: FactoryBot.attributes_for(:admin) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      #FAILER!!
      it 'リクエストが成功すること' do
        post users_path,
             params: { admin: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end
#FAILER!!
      it 'ユーザーが登録されないこと' do
        expect do
          post users_path,
               params: { admin: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end
#FAILER!!
      it 'エラーが表示されること' do
        post users_path,
             params: { admin: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end

describe 'PUT #update' do
  context 'パラメータが妥当な場合' do   
    it 'リクエストが成功すること' do
      put user_path admin, params: { admin: FactoryBot.attributes_for(:admim) }
      expect(response.status).to eq 302
    end

    it 'ユーザー名が更新されること' do
      expect do
        put user_path admin,
                      params: { admin: FactoryBot.attributes_for(:user) }
      end.to change { User.find(user.id).name }.from('user1').to('user2')
    end

    it 'リダイレクトすること' do
      put user_path admin, params: { admin: FactoryBot.attributes_for(:user) }
      expect(response).to redirect_to User.last
    end
  end

  context 'パラメータが不正な場合' do
    it 'リクエストが成功すること' do
      put user_path admin,
                    params: { admin: FactoryBot.attributes_for(:user1,
                                                               :invalid) }
      expect(response.status).to eq 200
    end

    it 'ユーザー名が変更されないこと' do
      expect do
        put user_path admin,
                      params: { admin: FactoryBot.attributes_for(:user1,
                                                                 :invalid) }
      end.to_not change(User.find(user.id), :name)
    end

    it 'エラーが表示されること' do
      put user_path admin,
                    params: { admin: FactoryBot.attributes_for(:user1,
                                                               :invalid) }
      expect(response.body).to include 'prohibited this user from being saved'
    end
  end


describe 'DELETE #destroy' do
let!(:admin) { FactoryBot.create(:admin) }
let!(:guestuser) { FactoryBot.create(:guestuser) }
  
context 'as a admin' do
    before do
      login_as(admin)
    end

    #SUCCESS!
    it 'リクエストが成功すること' do
      delete user_path(admin)
      expect(response.status).to eq 302
    end

    it 'ユーザーが削除されること' do
      expect do
        delete user_path(admin)
      end.to change(User.all, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete user_path(admin)
      expect(response).to redirect_to(users_path)
    end
  end
  
  context 'as a guestuser' do
    before do
      login_as(guestuser)
    end
    
    #SUCCESS!
    it ' 正常にレスポンスが返ってきているか' do
      delete user_path(admin)
      expect(response).to_not be_success
    end
    it '302レスポンスが返ってきているか' do
      delete user_path(admin)
    end
    it 'ログイン画面にリダイレクトされているか' do
      delete user_path(admin)
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end

# Webリクエストが成功したか
# 正しいページにリダイレクトされたか
# ユーザー認証が成功したか
# レスポンスのテンプレートに正しいオブジェクトが保存されたか
# ビューに表示されたメッセージは適切か

#FAILER!!
# shared_context 'log_in' do
#   session[:user_id] = user1.id
# end

# before_action :logged_in_user,
# only: %i[edit update destroy following followers]
# before_action :correct_user, only: %i[edit update]
# before_action :check_guest, only:  %i[destroy update]

#   describe 'A' do
#     before { get :show, id:@user.id }
#     it { expect(response.status).to eq(200) }
#     it { expect(response).to render_template show }
#     it { expect(assings(:user)).to eq @user }
# end

# RSpec.describe 'Users', type: :request do
#   before do
#     @user = User.new(
#       name: "admin",
#       email: "admin@example.com",
#       admin: true,
#       activated_at: Time.zone.now,
#       created_at:   Time.zone.now
#              )

#              log_in(@user)
#              session[:user_id] = @user.id
#              get login_path
#   end
# end




# ===================ABILITY===================

# describe 'abilities' do
#   # ユーザーを定義
#   let!(:admin) { FactoryBot.create(:admin) }
#   # このスコープ内ではAbilityの生成コードを毎回書かなくても良いようにsubject化
#   subject { Ability.new(admin) }
#   it { is_expected.to be_able_to(:create, Item.new) }
#   it { is_expected.to_not be_able_to(:destroy, Item.new) }
# end

# describe "abilities" do
#   # user = User.create!
#   ability = Ability.new(user)
#   expect(ability).to be_able_to(:create, Post.new)
#   expect(ability).to_not be_able_to(:destroy, Post.new)
# end

# expect(ability).to_not be_able_to(:destroy, Item.new)

#   test "user can only destroy projects which they own" do

#     describe "User" do

#     #FactoryBotでいける!!
#     context '自分のモデルデータしか削除できないテスト'
#     user = User.create!

#     before do
#      ability = Ability.new(user1)
#      admin_ability = Ability.new(admin)
#     end

#     it 'adminはすべてのデータを削除できる' do

#       admin_ability.should be_able_to(:destroy, Item.new)
#       admin_ability.should be_able_to(:destroy, Cordinate.new)
#       admin_ability.should be_able_to(:destroy, Comment.new)

#     end

#     it 'Cordinateは自分の所有するものしか削除できない' do
#       ability.should be_able_to(:destroy, Cordinate.new(user: user1))
#       ability.should_not be_able_to(:destroy, Cordinate.new)
#     end

#     it 'Itemは自分の所有するものしか削除できない' do
#       ability.should be_able_to(:destroy, Cordinate.new(user: user1))
#       ability.should_not be_able_to(:destroy, Cordinate.new)
#     end

#     it 'Itemは自分の所有するものしか削除できない' do
#       ability.should be_able_to(:destroy, Cordinate.new(user: user1))
#       ability.should_not be_able_to(:destroy, Cordinate.new)
#     end

#   end
# end
