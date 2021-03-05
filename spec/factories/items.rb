FactoryBot.define do
  factory :item do
    user_id { 1 }
    cordinate_id { 1 }
    super_item { 1 }
    season { 1 }
    tpo { 1 }
    color { 1 }
    content { 1 }
    memo { 'MyText' }
    picture { 'MyString' }
    rating { 1.5 }
  end
end
