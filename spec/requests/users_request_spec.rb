# rspec ./spec/requests/users_request_spec.rb

# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

# shared_context 'log_in' do
#   session[:user_id] = user1.id
# end

# before_action :logged_in_user,
# only: %i[edit update destroy following followers]
# before_action :correct_user, only: %i[edit update]
# before_action :check_guest, only:  %i[destroy update]

with_session(:admin) do


end

RSpec.describe 'Users', type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  # otherをuserに変えて使用している。
  # let(:user1) { FactoryBot.create(:user1) }
  # let(:blockuser) { FactoryBot.create(:blockuser) }

  # let(:cordinate1) { FactoryBot.create(:cordinate1, user_id: admin.id) }
  # let(:cordinate2) { FactoryBot.create(:cordinate2, user_id: admin.id) }
  # let(:cordinate4) { FactoryBot.create(:cordinate4, user_id: user.id) }
  # let(:cordinate5) { FactoryBot.create(:cordinate5, user_id: user.id) }

  # let(:item11) do
  #   FactoryBot.create(:item11, user_id: user.id, cordinate_id: cordinate4.id)
  # end
  # let(:item12) do
  #   FactoryBot.create(:item12, user_id: user.id, cordinate_id: cordinate4.id)
  # end

  # let(:comment1) do
  #   FactoryBot.create(:comment1, user_id: user.id, cordinate_id: cordinate1.id)
  # end
  # let(:comment2) do
  #   FactoryBot.create(:comment2, user_id: user.id, cordinate_id: cordinate2.id)
  # end
  # let(:likecordiante1) do
  #   FactoryBot.create(:likecordinate1, user_id: user.id,
  #                                      cordinate_id: cordinate1.id)
  # end
  # let(:likecordiante2) do
  #   FactoryBot.create(:likecordinate2, user_id: user.id,
  #                                      cordinate_id: cordinate2.id)
  # end

  # ===================ABILITY===================

  Rspec.describe User do
    describe 'ability' do
      context 'friendの場合' do
        before do
          @params = {}

          it '友達のコーディネートをつくれる' do
            it { is_expected.to be_able_to(:create, Cordinate.new) }
          end
        end
      end
    end
  end

  describe 'abilities' do
    # ユーザーを定義
    let!(:admin) { FactoryBot.create(:admin) }
    # このスコープ内ではAbilityの生成コードを毎回書かなくても良いようにsubject化
    subject { Ability.new(admin) }
    it { is_expected.to be_able_to(:create, Item.new) }
    it { is_expected.to_not be_able_to(:destroy, Item.new) }
  end

  # describe "abilities" do
  #   # user = User.create!
  #   ability = Ability.new(user)
  #   expect(ability).to be_able_to(:create, Post.new)
  #   expect(ability).to_not be_able_to(:destroy, Post.new)
  # end

  # ユーザーを定義
  let!(:admin) { FactoryBot.create(:admin) }
  # このスコープ内ではAbilityの生成コードを毎回書かなくても良いようにsubject化
  subject { Ability.new(admin) }
  it 'it true' do
    expect(ability).to be_able_to(:create, Item.new)
    expect(ability).to_not be_able_to(:destroy, Item.new)
  end
end

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

#   # ===================INDEX===================
#   describe '#index' do
#     # 正常なレスポンスか？
#     it 'responds successfully' do
#       get :index
#       expect(response).to be_success
#     end
#     # 200レスポンスが返ってきているか？
#     it 'returns a 200 response' do
#       get :index
#       expect(response).to have_http_status '200'
#     end
#   end

#   describe '#show' do
#     # 正常なレスポンスか？
#     it 'responds successfully' do
#       get :show, params: { id: admin.id }
#       expect(response).to be_success
#     end
#     # 200レスポンスが返ってきているか？
#     it 'returns a 200 response' do
#       get :show, params: { id: admin.id }
#       expect(response).to have_http_status '200'
#     end
#   end

#   # ===================SHOW===================
#   describe 'GET #show' do
#     context 'ユーザーが存在する場合' do
#       it 'リクエストが成功すること' do
#         get user_path admin
#         expect(response.status).to eq 200
#       end

#       it 'ユーザー名が表示されていること' do
#         get user_path admin
#         expect(response.body).to include 'admin'
#       end
#     end

#     context 'ユーザーが存在しない場合' do
#       subject { -> { get user_path 1 } }

#       it { is_expected.to raise_error ActiveRecord::RecordNotFound }
#     end
#   end

#   # ===================NEW===================
#   describe 'GET #new' do
#     it 'リクエストが成功すること' do
#       get new_user_path
#       expect(response.status).to eq 200
#     end
#   end

#   # ===================EDIT===================

#   describe 'GET #edit' do
#     it 'リクエストが成功すること' do
#       get edit_user_path admin
#       expect(response.status).to eq 200
#     end

#     it 'ユーザー名が表示されていること' do
#       get edit_user_path admin
#       expect(response.body).to include 'admin'
#     end

#     it 'メールアドレスが表示されていること' do
#       get edit_user_path admin
#       expect(response.body).to include 'admin@example.com'
#     end
#   end

#   # ===================CREATE===================
#   describe 'POST #create' do
#     context 'パラメータが妥当な場合' do
#       it 'リクエストが成功すること' do
#         post users_path, params: { admin: FactoryBot.attributes_for(:user1) }
#         expect(response.status).to eq 302
#       end

#       it 'ユーザーが登録されること' do
#         expect do
#           post users_path, params: { admin: FactoryBot.attributes_for(:user1) }
#         end.to change(User, :count).by(1)
#       end

#       it 'リダイレクトすること' do
#         post users_path, params: { admin: FactoryBot.attributes_for(:user1) }
#         expect(response).to redirect_to User.last
#       end
#     end

#     context 'パラメータが不正な場合' do
#       it 'リクエストが成功すること' do
#         post users_path,
#              params: { admin: FactoryBot.attributes_for(:user1, :invalid) }
#         expect(response.status).to eq 200
#       end

#       it 'ユーザーが登録されないこと' do
#         expect do
#           post users_path,
#                params: { admin: FactoryBot.attributes_for(:user1, :invalid) }
#         end.to_not change(User, :count)
#       end

#       it 'エラーが表示されること' do
#         post users_path,
#              params: { admin: FactoryBot.attributes_for(:user1, :invalid) }
#         expect(response.body).to include 'prohibited this user from being saved'
#       end
#     end
#   end

#   # ===================UPDATE===================
#   describe 'PUT #update' do
#     context 'パラメータが妥当な場合' do
#       it 'リクエストが成功すること' do
#         put user_path admin, params: { admin: FactoryBot.attributes_for(:user1) }
#         expect(response.status).to eq 302
#       end

#       it 'ユーザー名が更新されること' do
#         expect do
#           put user_path admin,
#                         params: { admin: FactoryBot.attributes_for(:user1) }
#         end.to change { User.find(user.id).name }.from('user1').to('user2')
#       end

#       it 'リダイレクトすること' do
#         put user_path admin, params: { admin: FactoryBot.attributes_for(:user1) }
#         expect(response).to redirect_to User.last
#       end
#     end

#     context 'パラメータが不正な場合' do
#       it 'リクエストが成功すること' do
#         put user_path admin,
#                       params: { admin: FactoryBot.attributes_for(:user1,
#                                                                  :invalid) }
#         expect(response.status).to eq 200
#       end

#       it 'ユーザー名が変更されないこと' do
#         expect do
#           put user_path admin,
#                         params: { admin: FactoryBot.attributes_for(:user1,
#                                                                    :invalid) }
#         end.to_not change(User.find(user.id), :name)
#       end

#       it 'エラーが表示されること' do
#         put user_path admin,
#                       params: { admin: FactoryBot.attributes_for(:user1,
#                                                                  :invalid) }
#         expect(response.body).to include 'prohibited this user from being saved'
#       end
#     end
#   end

#   # ===================DELETE===================

#   describe 'DELETE #destroy' do
#     it 'リクエストが成功すること' do
#       delete user_path admin
#       expect(response.status).to eq 302
#     end

#     it 'ユーザーが削除されること' do
#       expect do
#         delete user_path admin
#       end.to change(User, :count).by(-1)
#     end

#     it 'ユーザー一覧にリダイレクトすること' do
#       delete user_path admin
#       expect(response).to redirect_to(users_path)
#     end
#   end
