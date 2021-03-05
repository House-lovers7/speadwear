FactoryBot.define do
  factory :cordinate do
    user_id { 1 }
    item_id { 1 }
    comment_id { 1 }
    likecordinate_id { 1 }
    season { 1 }
    tpo { 1 }
    picture { "MyString" }
    si_shoes { 1 }
    si_botoms { 1 }
    si_tops { 1 }
    si_outer { 1 }
    memo { "MyText" }
    rating { 1.5 }
  end
end
