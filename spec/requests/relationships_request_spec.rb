# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  # otherをuserに変えて使用している。
  let(:user) { FactoryBot.create(:user) }
  let(:blockuser) { FactoryBot.create(:blockuser) }

  let(:cordinate1) { FactoryBot.create(:cordinate1, user_id: admin.id) }
  let(:cordinate2) { FactoryBot.create(:cordinate2, user_id: admin.id) }
  let(:cordinate4) { FactoryBot.create(:cordinate4, user_id: user.id) }
  let(:cordinate5) { FactoryBot.create(:cordinate5, user_id: user.id) }

  let(:item11) do
    FactoryBot.create(:item11, user_id: user.id, cordinate_id: cordinate4.id)
  end
  let(:item12) do
    FactoryBot.create(:item12, user_id: user.id, cordinate_id: cordinate4.id)
  end

  let(:comment1) do
    FactoryBot.create(:comment1, user_id: user.id, cordinate_id: cordinate1.id)
  end
  let(:comment2) do
    FactoryBot.create(:comment2, user_id: user.id, cordinate_id: cordinate2.id)
  end
  let(:likecordiante1) do
    FactoryBot.create(:likecordinate1, user_id: user.id,
                                       cordinate_id: cordinate1.id)
  end
  let(:likecordiante2) do
    FactoryBot.create(:likecordinate2, user_id: user.id,
                                       cordinate_id: cordinate2.id)
  end

  # ===================INDEX===================
  describe '#index' do
    # 正常なレスポンスか？
    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end
    # 200レスポンスが返ってきているか？
    it 'returns a 200 response' do
      get :index
      expect(response).to have_http_status '200'
    end
  end

  describe '#show' do
    # 正常なレスポンスか？
    it 'responds successfully' do
      get :show, params: { id: user.id }
      expect(response).to be_success
    end
    # 200レスポンスが返ってきているか？
    it 'returns a 200 response' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status '200'
    end
  end

  # ===================SHOW===================
  describe 'GET #show' do
    context 'ユーザーが存在する場合' do
      let(:user) { FactoryBot.create(:user) }

      it 'リクエストが成功すること' do
        get user_url user.id
        expect(response.status).to eq 200
      end

      it 'ユーザー名が表示されていること' do
        get user_url user.id
        expect(response.body).to include 'user1'
      end
    end

    context 'ユーザーが存在しない場合' do
      subject { -> { get user_url 1 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  # ===================NEW===================
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_user_url
      expect(response.status).to eq 200
    end
  end

  # ===================EDIT===================
  describe 'GET #edit' do
    let(:user) { FactoryBot.create(:user) }

    it 'リクエストが成功すること' do
      get edit_user_url 　user
      expect(response.status).to eq 200
    end

    it 'ユーザー名が表示されていること' do
      get edit_user_url user
      expect(response.body).to include 'user1'
    end

    it 'メールアドレスが表示されていること' do
      get edit_user_url user
      expect(response.body).to include 'user1@example.com'
    end
  end

  # ===================CREATE===================
  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'リダイレクトすること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_url,
             params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_url,
               params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post users_url,
             params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end

  # ===================UPDATE===================
  describe 'PUT #update' do
    let(:user) { FactoryBot.create(:user) }

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put user_url user, params: { user: FactoryBot.attributes_for(:user2) }
        expect(response.status).to eq 302
      end

      it 'ユーザー名が更新されること' do
        expect do
          put user_url user, params: { user: FactoryBot.attributes_for(:user2) }
        end.to change { User.find(user.id).name }.from('user1').to('user2')
      end

      it 'リダイレクトすること' do
        put user_url user, params: { user: FactoryBot.attributes_for(:user2) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put user_url user,
                     params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'ユーザー名が変更されないこと' do
        expect do
          put user_url user,
                       params: { user: FactoryBot.attributes_for(:user,
                                                                 :invalid) }
        end.to_not change(User.find(user.id), :name)
      end

      it 'エラーが表示されること' do
        put user_url user,
                     params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end

  # ===================DELETE===================

  describe 'DELETE #destroy' do
    let!(:user) { FactoryBot.create(:user) }

    it 'リクエストが成功すること' do
      delete user_url user
      expect(response.status).to eq 302
    end

    it 'ユーザーが削除されること' do
      expect do
        delete user_url user
      end.to change(User, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete user_url user
      expect(response).to redirect_to(users_url)
    end
  end
end
