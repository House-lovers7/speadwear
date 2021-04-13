# rspec ./spec/requests/items_request_spec.rb
# frozen_string_literal: true


require 'rails_helper'
# require 'cancan/matchers'

RSpec.describe 'Items', type: :request do

  let!(:admin) {create(:admin)}
  let!(:blockuser) {build(:blockuser) }
  let!(:cordinate1) {create(:cordinate1, user_id: admin.id)}
  let!(:cordinate2) {FactoryBot.build(:cordinate2, user_id: admin.id)}
  let!(:item1) {create(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
      
  # describe '#index' do  

  # before do        
  #   login_as(admin)
  #   get items_path(item1)    
  # end
  #   fit '正常なレスポンスか' do                       
  #     expect(response).to be_success
  #   end     
  #   fit '200レスポンスが返ってきているか' do
  #     get :index
  #     expect(response).to have_http_status '200'
  #   end
  # end

  describe '#show' do
    it '正常なレスポンスか' do               
      get items_path(item1)      
      expect(response).to be_success      
    end
    # 
    it '200レスポンスが返ってきているか？' do
      get items_path(user_id: admin.id, id: item1.id)   
      expect(response).to have_http_status '200'
    end
  end
    
  describe 'GET #show' do
    context 'アイテムが存在する場合' do
      
      it 'リクエストが成功すること' do
        get items_path(item1)      
        expect(response.status).to eq 200        
      end
      it 'ユーザー名が表示されていること' do
        get items_path(item1)      
        expect(response.body).to include 'item1'
      end
    end

    context 'ユーザーが存在しない場合' do
      subject { -> { get user_url 1 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
  
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_item_path(item1)
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do    
    it 'リクエストが成功すること' do
                             
      get item_edit_path(user_id: admin.id, id: item1.id)
      expect(response.status).to eq 200
    end

    it 'ユーザー名が表示されていること' do
      get item_edit_path(user_id: admin.id, id: item1.id)
      expect(response.body).to include 'item.rating'
    end

  end


#    # itemsコントローラー(個別User)
#    get '/users/:user_id/items/all', to: 'items#user_all_item_show',
#    as: 'user_item'
# get '/users/:user_id/items/new', to: 'items#new', as: 'item_new'
# get '/users/:user_id/items/:id', to: 'items#show', as: 'item_show'
# patch '/users/:user_id/items/:id/edit', to: 'items#update', as: 'item_update'
# get '/users/:user_id/items/:id/edit', to: 'items#edit', as: 'item_edit'
# get '/users/:user_id/cordinates/:cordinate_id/items',
# to: 'items#cordinate_show', as: 'cordinate_item_show'
# get '/users/:user_id/cordinates/:cordinate_id/items/search', to: 'items#cordinate_search_si',
#                                as: 'cordinate_search_si'
# post '/users/:user_id/items/', to: 'items#create', as: 'item_create'
# delete '/users/:user_id/items/:id', to: 'items#destroy', as: 'item_delete'


  # ===================CREATE===================
  
  describe 'POST #create' do
    
  context 'パラメータが妥当な場合' do
      fit 'リクエストが成功すること' do
        post item_create_path(id: 1, user_id: admin.id, super_item: 1, seasomn: 2, tpo: 3, rating: 4, color: 1, content: 3, memo: "差し色グリーンがナイス!")
        expect(response.status).to eq 302
      end

      # fit 'ユーザーが登録されること' do        
      #   post item_create_path
      #   end.to change(User, :count).by(1)
      # end

      fit 'リダイレクトすること' do
        post item_create_path(id: 1, user_id: admin.id, super_item: 1, seasomn: 2, tpo: 3, rating: 4, color: 1, content: 3, memo: "差し色グリーンがナイス!")
        expect(response).to redirect_to User.last
      end
    end
  end




    # context 'パラメータが不正な場合' do
    #   fit 'リクエストが成功すること' do
    #     post item_create_path             
    #     expect(response.status).to eq 200
    #   end

    #   it 'ユーザーが登録されないこと' do
    #     expect do
    #       post users_url,
    #            params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     end.to_not change(User, :count)
    #   end

    #   it 'エラーが表示されること' do
    #     post users_url,
    #          params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     expect(response.body).to include 'prohibited this user from being saved'
    #   end
    # end
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
