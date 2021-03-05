FactoryBot.define do
  factory :user do
    name { 'MyString' }
    email { 'MyString' }
    picture { 'MyString' }
    cordinate_id { 1 }
    item_id { 1 }
    comment_id { 1 }
    admin { false }
    password_digest { 'MyString' }
    remember_digest { 'MyString' }
    reset_digest { 'MyString' }
  end
end
