# rspec ./spec/models/item_spec.rb

#frozen_string_literal: true
require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Item, type: :model do
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }
  let!(:item1) {build(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
  let(:cordinate1) { create(:cordinate1, user_id: admin.id) }

describe '存在性チェック' do

  #SUCCESS!!
  it 'buildデータが有効であること' do            
    expect(item1).to be_valid
  end

  #SUCCESS!!
  it 'user_idがなければ無効な状態であること' do    
    item1.user_id = nil
    item1.valid?
    expect(item1.errors[:user_id]).to include('を入力してください')        
  end

  #SUCCESS!!
  it 'super_itemがなければ無効な状態であること' do
    item1.super_item = nil
    item1.valid?
    expect(item1.errors[:super_item]).to include('を入力してください')
  end
#SUCCESS!!
  it 'seasonがなければ無効な状態であること' do
    item1.season = nil
    item1.valid?
    expect(item1.errors[:season]).to include('を入力してください')
  end

  #SUCCESS!!
  it 'tpoがなければ無効な状態であること' do
    item1.tpo = nil
    item1.valid?
    expect(item1.errors[:tpo]).to include('を入力してください')
  end
 
  #FAILER!! 個別にやるとSUCCESS なぜにratingdだけErrorが出るのか？ 
  it 'ratingがなければ無効な状態であること' do
    item1.rating = nil
    item1.valid?
    expect(item1.errors[:rating]).to include('を入力してください')
  end
 
  #SUCCESS!!
  it 'contentがなければ無効な状態であること' do
    item1.content = nil
    item1.valid?
    expect(item1.errors[:content]).to include('を入力してください')
  end

  #SUCCESS!!
  it 'colorがなければ無効な状態であること' do
    item1.color = nil
    item1.valid?
    expect(item1.errors[:color]).to include('を入力してください')
  end
end

#SUCCESS!!
describe 'メモの長さ' do
  it '141文字の内容は無効であること' do
    item1.memo = 'あ' * 141
    item1.valid?
    expect(item1).to_not be_valid    
  end
  
  #SUCCESS!!
  it '140文字の内容は有効であること' do
    item1.memo = 'あ' * 140           
    expect(item1).to be_valid
  end
end

describe '画像のアップロード' do
  #SUCCESS!!
  it '画像なしでも有効であること' do                        
    item1.picture = nil
    expect(item1).to be_valid
  end

  #FAILER!!
  it '画像なしの場合、デフォルト画像が設定されること' do    
    item1.picture = nil
    expect(item1.picture.url).to eq '/default/no_image.png'
  end
 
  #FAILER!!
  it 'デフォルト画像以外の画像を設定できること' do
    # image_path = Rails.root.join("public/default/default_user.png")
    # item = FactoryBot.build(:item, manufacturer: manufacturer, category: category, image: File.open(image_path))
    # item.save
    expect(item.image.url).to eq "/uploads/item/image/#{item.id}/default.png"
  end
end
end
