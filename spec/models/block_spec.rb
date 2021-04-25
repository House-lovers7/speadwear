# frozen_string_literal: true
#rspec ./spec/models/block_spec.rb
require 'rails_helper'
RSpec.describe Block, type: :model do

  let!(:user) { build(:user) }
  let!(:admin) { build(:admin) }
  let!(:other) { build(:other) }
  let!(:blockuser) { build(:blockuser) }
  let(:block1){FactoryBot.build(:block1, blocker_id: admin.id, blocked_id: blockuser.id)}


  #SUCCESS!!
  it '有効なファクトリを持つこと' do    
    expect(block1).to be_valid
  end

  describe 'blocker_id、blocked_idの存在' do      
    #SUCCESS!!
    it 'blocker_id、blocked_idの両方があれば有効な状態であること' do      
      expect(block1).to be_valid
    end
    #SUCCESS!!
    it 'blocker_idがなければ無効な状態であること' do
      block1.blocker_id = nil      
      block1.valid?
      expect(block1.errors[:blocker_id]).to include('を入力してください')
    end
    
    #SUCCESS!!
    it 'blocked_idがなければ無効な状態であること' do
      block1.blocked_id = nil      
      block1.valid?
      expect(block1.errors[:blocked_id]).to include('を入力してください')
    end
  end

  #FAILER!!
  it '自分自身をブロックできないこと' do
    block1.blocked_id = admin.id           
    block1.valid?
    expect(block1.errors[:blocked_id]).to include('自分自身をブロックすることはできません')
  end

  #FAILER!!
  it '同じ人を2回以上ブロックできないこと' do
    Block.create(blocked_id: User.first.id, blocker_id: User.second.id)
    block = Block.new(blocked_id: User.first.id, blocker_id: User.second.id)
    block.valid?
    expect(block.errors[:blocked_id]).to include('はすでに存在します')
  end

  #FAILER!!
  fit '作成と削除ができること' do
    # expect { FactoryBot.create(:block) }.to change(Block.all, :count).by(1)   
    expect do
      post blockers_user_path(admin)
    end.to change(User, :count).by(1)

    expect do
      delete blockers_user_path(admin)
    end.to change(User, :count).by(-1)
  
  end
end
