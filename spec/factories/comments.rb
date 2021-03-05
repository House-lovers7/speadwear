FactoryBot.define do
  factory :comment do
    user_id { 1 }
    cordinate_id { 1 }
    comment { 'MyString' }
  end
end
