# spec ./spec/models/notification_spec.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do

  let!(:user) { build(:user) }
  let!(:admin) { build(:admin) }
  let!(:other) { build(:other) }
  let!(:blockuser) { build(:blockuser) }

let!(:notification1) {create(:notification1, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate1.id)}
let!(:notification2) {create(:notification2, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate2.id)}
let!(:notification3) {create(:notification3, sender_id: blockuser.id, receiver_id: admin.id, cordinate_id: cordinate3.id)}
let!(:notification4) {create(:notification4, sender_id: blockuser.id, receiver_id: other.id, comment_id: comment4.id)}
  
let!(:cordinate1) {create(:cordinate1, user_id: admin.id)}
let!(:cordinate2) {create(:cordinate2, user_id: admin.id)}
let!(:cordinate3) {create(:cordinate3, user_id: admin.id)}
let!(:cordinate4) {create(:cordinate4, user_id: other.id)}
let!(:cordinate5) {create(:cordinate5, user_id: other.id)}
let!(:cordinate6) {create(:cordinate6, user_id: other.id)}
let!(:cordinate7) {create(:cordinate7, user_id: blockuser.id)}
let!(:cordinate8) {create(:cordinate8, user_id: blockuser.id)}
let!(:cordinate9) {create(:cordinate9, user_id: blockuser.id)}

# item1 = FactoryBot.create(:item1, user_id: admin.id, cordinate_id: cordinate1.id)
# item2 = FactoryBot.create(:item2, user_id: admin.id, cordinate_id: cordinate1.id)
# item3 = FactoryBot.create(:item3, user_id: admin.id, cordinate_id: cordinate1.id)
# item4 = FactoryBot.create(:item4, user_id: admin.id, cordinate_id: cordinate2.id)
# item5 = FactoryBot.create(:item5, user_id: admin.id, cordinate_id: cordinate2.id)
# item6 = FactoryBot.create(:item6, user_id: admin.id, cordinate_id: cordinate2.id)
# item7 = FactoryBot.create(:item7, user_id: admin.id, cordinate_id: cordinate3.id)
# item8 = FactoryBot.create(:item8, user_id: admin.id, cordinate_id: cordinate3.id)
# item9 = FactoryBot.create(:item9, user_id: admin.id, cordinate_id: cordinate3.id)
# item10 = FactoryBot.create(:item10, user_id: admin.id, cordinate_id: cordinate3.id)
# item11 = FactoryBot.create(:item11, user_id: other.id, cordinate_id: cordinate4.id)

# ActiveRecord::RecordInvalid (バリデーションに失敗しました: Followerを入力してください, Followedを入力してください)

# likecordinate1 = FactoryBot.create(:likecordinate1, user_id: other.id, cordinate_id: cordinate1.id)
# likecordinate2 = FactoryBot.create(:likecordinate2, user_id: other.id, cordinate_id: cordinate2.id)
# likecordinate3 = FactoryBot.create(:likecordinate3, user_id: other.id, cordinate_id: cordinate3.id)
# likecordinate4 = FactoryBot.create(:likecordinate4, user_id: blockuser.id, cordinate_id: cordinate4.id)
# likecordinate5 = FactoryBot.create(:likecordinate5, user_id: blockuser.id, cordinate_id: cordinate5.id)
# likecordinate6 = FactoryBot.create(:likecordinate6, user_id: admin.id, cordinate_id: cordinate6.id)
# likecordinate7 = FactoryBot.create(:likecordinate7, user_id: other.id, cordinate_id: cordinate7.id)
# likecordinate8 = FactoryBot.create(:likecordinate8, user_id: other.id, cordinate_id: cordinate8.id)

# relationship1 = FactoryBot.create(:relationship1, follower_id: admin.id, followed_id: other.id)
# relationship2 = FactoryBot.create(:relationship2, follower_id: admin.id, followed_id: blockuser.id)
# relationship3 = FactoryBot.create(:relationship3, follower_id: other.id, followed_id: blockuser.id)
# relationship4 = FactoryBot.create(:relationship4, follower_id: other.id, followed_id: admin.id)

# block1 = FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)

# comment1 = FactoryBot.create(:comment1, user_id: other.id, cordinate_id: cordinate1.id)
# comment2 = FactoryBot.create(:comment2, user_id: other.id, cordinate_id: cordinate2.id)
# comment3 = FactoryBot.create(:comment3, user_id: blockuser.id, cordinate_id: cordinate3.id)
# comment4 = FactoryBot.create(:comment4, user_id: admin.id, cordinate_id: cordinate4.id)
# comment5 = FactoryBot.create(:comment5, user_id: admin.id, cordinate_id: cordinate5.id)
# comment6 = FactoryBot.create(:comment6, user_id: blockuser.id, cordinate_id: cordinate6.id)
# comment7 = FactoryBot.create(:comment7, user_id: other.id, cordinate_id: cordinate7.id)
# comment8 = FactoryBot.create(:comment7, user_id: other.id, cordinate_id: cordinate8.id)



  pending "add some examples to (or delete) #{__FILE__}"
end
