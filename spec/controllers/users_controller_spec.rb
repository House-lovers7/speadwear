# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  # module SessionsHelper
  #     # 渡されたユーザーでログインする
  #     def log_in(user)
  #       session[:user_id] = user.id
  #     end

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
end
