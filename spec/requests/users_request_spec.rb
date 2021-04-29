# rspec ./spec/requests/users_request_spec.rb
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:guestuser) { FactoryBot.create(:guestuser) }


describe 'PUT #update' do

context 'パラメータが妥当な場合' do
  
  before do
    @admin = FactoryBot.create(:admin)    
end

    
  it 'リクエストが成功すること' do
      
    update_params = FactoryBot.attributes_for(:admin,
    name: "update_admin")
     patch :update, id: admin.id , admin: attributes_for(:admin)
     expect(assigns(:admin)).to eq admin     
      # put user_path admin, params: { admin: FactoryBot.attributes_for(:admin) }
      # expect(response.status).to eq 302
    end

    fit 'ユーザー名が更新されること' do
      user_params = FactoryBot.attributes_for(:admin,
      name: "admin_update")
      
      binding.pry
      
      patch user_path admin, params: { id:@admin.id, name: user_params}
      expect(@admin.reload.name).to eq "admin_update"
      # expect do
      #   put user_path admin,
      #                 params: { admin: FactoryBot.attributes_for(:admin) }
      # end.to change { User.find(user.id).name }.from('user1').to('user2')
    end
  end

    it 'リダイレクトすること' do
      put user_path admin, params: { admin: FactoryBot.attributes_for(:admin) }
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
