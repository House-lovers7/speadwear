# frozen_string_literal: true
FactoryBot.find_definitions

FactoryBot.define do
  # factory :block do
  #   association :blocker
  #   association :blocked
  # end

  factory :block1, class: Block do
    blocker_id { admin.id }
    blocked_id { blockuser.id }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end

# associationメソッドの第一引数はモデルの名称、第二引数はモデルで定義しているfactoryの名称、第三引数以降はfactoryで定義している属性を上書きしたいときに使用。

# create_table "blocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "blocker_id"
#   t.integer "blocked_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["blocked_id"], name: "index_blocks_on_blocked_id"
#   t.index ["blocker_id", "blocked_id"], name: "index_blocks_on_blocker_id_and_blocked_id", unique: true
#   t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
# end

# ActiveRecord::RecordInvalid (バリデーションに失敗しました: Emailはすでに存在します)

# Traceback (most recent call last):
#         1: from (irb):14
# ActiveRecord::RecordInvalid (バリデーションに失敗しました: Userを入力してください)
