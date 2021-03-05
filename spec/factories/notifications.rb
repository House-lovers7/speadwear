FactoryBot.define do
  factory :notification1, class: Notification do
    sender_id { other.id }
    receiver_id { admin.id }
    cordinate_id { cordinate1.id }
    likecordinate_id { 1 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification2, class: Notification do
    sender_id { other.id }
    receiver_id { admin.id }
    cordinate_id { cordinate2.id }
    likecordinate_id { 2 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification3, class: Notification do
    sender_id { blockuser.id }
    receiver_id { admin.id }
    cordinate_id { cordinate3.id }
    likecordinate_id { 3 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification4, class: Notification do
    sender_id { blockuser.id }
    receiver_id { other.id }
    cordinate_id { cordinate4.id }
    likecordinate_id { 4 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification5, class: Notification do
    sender_id { blockuser.id }
    receiver_id { other.id }
    cordinate_id { cordinate5.id }
    likecordinate_id { 5 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification6, class: Notification do
    sender_id { admin.id }
    receiver_id { other.id }
    cordinate_id { cordinate6.id }
    likecordinate_id { 6 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification7, class: Notification do
    sender_id { other.id }
    receiver_id { blockuser.id }
    cordinate_id { cordinate7.id }
    likecordinate_id { 7 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification8, class: Notification do
    sender_id { other.id }
    receiver_id { blockuser.id }
    cordinate_id { cordinate8.id }
    likecordinate_id { 8 }
    action { 'likecordinate' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification9, class: Notification do
    sender_id { other.id }
    receiver_id { admin.id }
    action { 'follow' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification10, class: Notification do
    sender_id { admin.id }
    receiver_id { blockuser.id }
    action { 'follow' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification11, class: Notification do
    sender_id { other.id }
    receiver_id { blockuser.id }
    action { 'follow' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification12, class: Notification do
    sender_id { admin.id }
    receiver_id { other.id }
    action { 'follow' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification13, class: Notification do
    sender_id { other.id }
    receiver_id { admin.id }
    cordinate_id { cordinate1.id }
    comment_id { 1 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification14, class: Notification do
    sender_id { other.id }
    receiver_id { admin.id }
    cordinate_id { cordinate2.id }
    comment_id { 2 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification15, class: Notification do
    sender_id { blockuser.id }
    receiver_id { admin.id }
    cordinate_id { cordinate3.id }
    comment_id { 3 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification16, class: Notification do
    sender_id { admin.id }
    receiver_id { other.id }
    cordinate_id { cordinate4.id }
    comment_id { 4 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification17, class: Notification do
    sender_id { admin.id }
    receiver_id { other.id }
    cordinate_id { cordinate5.id }
    comment_id { 5 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification18, class: Notification do
    sender_id { blockuser.id }
    receiver_id { other.id }
    cordinate_id { cordinate6.id }
    comment_id { 6 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification19, class: Notification do
    sender_id { other.id }
    receiver_id { blockuser.id }
    cordinate_id { cordinate7.id }
    comment_id { 7 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  factory :notification20, class: Notification do
    sender_id { other.id }
    receiver_id { blockuser.id }
    cordinate_id { cordinate8.id }
    comment_id { 4 }
    action { 'comment' }
    checked { true }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end

# create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "sender_id", null: false
#   t.integer "receiver_id", null: false
#   t.integer "cordinate_id"
#   t.integer "comment_id"
#   t.integer "likecomment_id"
#   t.integer "likecordinate_id"
#   t.string "action", default: "", null: false
#   t.boolean "checked", default: false, null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["comment_id"], name: "index_notifications_on_comment_id"
#   t.index ["cordinate_id"], name: "index_notifications_on_cordinate_id"
#   t.index ["likecomment_id"], name: "index_notifications_on_likecomment_id"
#   t.index ["likecordinate_id"], name: "index_notifications_on_likecordinate_id"
#   t.index ["receiver_id"], name: "index_notifications_on_receiver_id"
#   t.index ["sender_id"], name: "index_notifications_on_sender_id"
# end

# user→cordinate→itemの順番で作成する。

# let(:admin) = {FactoryBot.create(:admin)}
# let(:user) { FactoryBot.create(:user) }

# let(:cordinate1) {FactoryBot.create(:cordinate1, user_id: admin.id)}
# let(:item1) {FactoryBot.create(:item1, user_id: admin.id, cordinate_id: cordinate1.id)}
# let(:likecordinate1) = {FactoryBot.create(:likecordinate1, user_id: other.id, cordinate_id: cordinate1.id)}
# let(:relationship1) = {FactoryBot.create(:relationship1, follower_id: admin.id, followed_id: other.id)}
# let(:block1) = {FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)}
# let(:comment1) = {FactoryBot.create(:comment1, user_id: other.id, cordinate_id: cordinate1.id)}
# let(:notification1) = {FactoryBot.create(:notification1, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate1.id)}

# admin = FactoryBot.create(:admin)
# other = FactoryBot.create(:other)
# blockuser = FactoryBot.create(:blockuser)
# guest = FactoryBot.create(:guestuser)

# cordinate1 = FactoryBot.create(:cordinate1, user_id: admin.id)
# cordinate2 = FactoryBot.create(:cordinate2, user_id: admin.id)
# cordinate3 = FactoryBot.create(:cordinate3, user_id: admin.id)
# cordinate4 = FactoryBot.create(:cordinate4, user_id: other.id)
# cordinate5 = FactoryBot.create(:cordinate5, user_id: other.id)
# cordinate6 = FactoryBot.create(:cordinate6, user_id: other.id)
# cordinate7 = FactoryBot.create(:cordinate7, user_id: blockuser.id)
# cordinate8 = FactoryBot.create(:cordinate8, user_id: blockuser.id)

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

# item12 = FactoryBot.create(:item12, user_id: other.id, cordinate_id: cordinate4.id)
# item13 = FactoryBot.create(:item13, user_id: other.id, cordinate_id: cordinate4.id)
# item14 = FactoryBot.create(:item14, user_id: other.id, cordinate_id: cordinate4.id)
# item15 = FactoryBot.create(:item15, user_id: other.id, cordinate_id: cordinate5.id)
# item16 = FactoryBot.create(:item16, user_id: other.id, cordinate_id: cordinate5.id)
# item17 = FactoryBot.create(:item17, user_id: other.id, cordinate_id: cordinate5.id)
# item18 = FactoryBot.create(:item18, user_id: other.id, cordinate_id: cordinate5.id)
# item19 = FactoryBot.create(:item19, user_id: other.id, cordinate_id: cordinate6.id)
# item20 = FactoryBot.create(:item20, user_id: other.id, cordinate_id: cordinate6.id)
# item21 = FactoryBot.create(:item21, user_id: other.id, cordinate_id: cordinate6.id)
# item22 = FactoryBot.create(:item22, user_id: other.id, cordinate_id: cordinate6.id)
# item23 = FactoryBot.create(:item23, user_id: blockuser.id, cordinate_id: cordinate7.id)

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

# notification1 = FactoryBot.create(:notification1, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate1.id)
# notification2 = FactoryBot.create(:notification2, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate2.id)
# notification3 = FactoryBot.create(:notification3, sender_id: blockuser.id, receiver_id: admin.id, cordinate_id: cordinate3.id)
# notification4 = FactoryBot.create(:notification4, sender_id: blockuser.id, receiver_id: other.id, comment_id: comment4.id)
# notification5 = FactoryBot.create(:notification5, sender_id: blockuser.id, receiver_id: other.id, comment_id: comment5.id)
# notification6 = FactoryBot.create(:notification6, sender_id: admin.id, receiver_id: other.id, cordinate_id: cordinate6.id)
# notification7 = FactoryBot.create(:notification7, sender_id: other.id, receiver_id: blockuser.id, cordinate_id: cordinate7.id)
# notification8 = FactoryBot.create(:notification8, sender_id: other.id, receiver_id: blockuser.id, cordinate_id: cordinate8.id)
# notification9 = FactoryBot.create(:notification9, sender_id: other.id, receiver_id: admin.id )
# notification10 = FactoryBot.create(:notification10, sender_id: admin.id, receiver_id: blockuser.id)

# notification11 = FactoryBot.create(:notification11, sender_id: other.id, receiver_id: blockuser.id)
# notification12 = FactoryBot.create(:notification12, sender_id: admin.id, receiver_id: other.id)
# notification13 = FactoryBot.create(:notification13, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate1.id)
# notification14 = FactoryBot.create(:notification14, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate2.id)
# notification15 = FactoryBot.create(:notification15, sender_id: blockuser.id, receiver_id: admin.id, cordinate_id: cordinate3.id)
# notification16 = FactoryBot.create(:notification16, sender_id: admin.id, receiver_id: other.id, cordinate_id: cordinate4.id)
# notification17 = FactoryBot.create(:notification17, sender_id: admin.id, receiver_id: other.id, cordinate_id: cordinate5.id)
# notification18 = FactoryBot.create(:notification18, sender_id: blockuser.id, receiver_id: other.id, cordinate_id: cordinate6.id)
# notification19 = FactoryBot.create(:notification19, sender_id: other.id, receiver_id: admin.id, cordinate_id: cordinate7.id)
# notification20 = FactoryBot.create(:notification20, sender_id: other.id, receiver_id: blockuser.id, cordinate_id: cordinate8.id)

# ActiveRecord::StatementInvalid (Mysql2::Error: Table 'speadwear_development_sub.comments' doesn't exist: SHOW FULL FIELDS FROM `comments`)
# irb(main):045:0> comment6 = FactoryBot.create(:comment6, user_id: blockuser.id, cordinate_id: cordinate6.id)
# Traceback (most recent call last):
#         2: from (irb):45

# 03:11:40">
# irb(main):018:0> block1 = FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)
#    (0.1ms)  SAVEPOINT active_record_1
#   User Load (0.2ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 1 LIMIT 1
#   User Load (0.2ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 3 LIMIT 1
#    (0.1ms)  ROLLBACK TO SAVEPOINT active_record_1
# Traceback (most recent call last):
#         1: from (irb):18
# ActiveRecord::RecordInvalid (バリデーションに失敗しました: Userを入力してください)
# irb(main):019:0>
