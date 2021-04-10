# frozen_string_literal: true

FactoryBot.define do
  factory :admin, class: User do
    sequence(:id) { |n|  n.to_s }
    sequence(:email) { |n| "admin#{n}@example.com" } # シーケンスを使う
    name { 'Admin' }
    # email { 'admin@example.com' }
    password { 'admin_pass' }
    # password_digest {User.digest("admin_pass" )}
    admin { true }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/satan.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :other, class: User do
    id { 2 }
    name { 'Other' }
    email { 'others@example.com' }
    password { 'others_pass' }
    admin { false }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/fox.jpg'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :blockuser, class: User do
    id { 3 }
    name { 'Blockuser' }
    email { 'block@example.com' }
    password { 'SecureRandom.urlsafe_base64' }
    admin { false }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/guy.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :guestuser, class: User do
    id { 4 }
    name { 'Guest' }
    email { 'guest@example.com' }
    password { 'SecureRandom.urlsafe_base64' }
    admin { false }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/guest.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :testuser, class: User do
    id { 5 }
    name { 'Testuser' }
    email { 'test@example.com' }
    password { 'SecureRandom.urlsafe_base64' }
    admin { false }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/woman.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :user, class: User do
    id { 6 }
    name { 'user' }
    sequence(:email) { |n| "user#{n}@example.com" } # シーケンスを使う
    sequence(:password) { |n| "user#{n}_pass" } # シーケンスを使う
    admin { false }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/guy2.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :friend, class: User do
    id {  7 }
    name { 'Friend' }
    email { 'friend@example.com' }
    password { 'friend_pass' }
    # password_digest {User.digest("admin_pass" )}
    admin { false }
    friend { true }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec/fixtures/fish.png'))
    end
    activated { true }
    activated_at { Time.zone.now }
  end
end

#   create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#     t.string "name"
#     t.string "email"
#     t.string "password_digest"
#     t.string "picture"
#     t.integer "cordinate_id"
#     t.integer "item_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.boolean "admin", default: false
#     t.string "activation_digest"
#     t.boolean "activated", default: false
#     t.datetime "activated_at"
#     t.string "remember_digest"
#     t.string "reset_digest"
#     t.datetime "reset_sent_at"
#     t.integer "comment_id"
#     t.index ["email"], name: "index_users_on_email", unique: true
#   end

# Aliases
# factory_bot allows you to define aliases to existing factories to make them easier to re-use.
# This could come in handy when, for example, your Post object has an author attribute that actually refers to an instance of a User class.
#  While normally factory_bot can infer the factory name from the association name, in this case it will look for an author factory in vain.
#  So, alias your user factory so it can be used under alias names.

# factory :user, aliases: [:author, :commenter] do
#   first_name { "John" }
#   last_name { "Doe" }
#   date_of_birth { 18.years.ago }
# end

# factory :post do
#   # The alias allows us to write author instead of
#   # association :author, factory: :user
#   author
#   title { "How to read a book effectively" }
#   body { "There are five steps involved." }
# end

# Factoryがないけど、関連付けをしたいケースで用いるのか？

# factory :comment do
#   # The alias allows us to write commenter instead of
#   # association :commenter, factory: :user
#   commenter
#   body { "Great article!" }
# end
