class Block < ApplicationRecord
  validates :blocker_id, presence: true
  validates :blocked_id, presence: true

  belongs_to :blocker, class_name: 'User',  optional: true
  belongs_to :blocked, class_name: 'User',  optional: true

  private

  # 自分自身をブロックしていないか検証する
  def self_block
    return unless blocker_id && blocked_id

    errors.add(:blocked_id, '自分自身をブロックすることはできません') if blocker_id == blocked_id
  end
end

# create_table "blocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
#   t.integer "blocker_id"
#   t.integer "blocked_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["blocked_id"], name: "index_blocks_on_blocked_id"
#   t.index ["blocker_id", "blocked_id"], name: "index_blocks_on_blocker_id_and_blocked_id", unique: true
#   t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
# end

# ActiveRecord::StatementInvalid (Mysql2::Error: Unknown column 'blocks.user_id' in 'where clause': SELECT `blocks`.* FROM `blocks` WHERE `blocks`.`user_id` = 19)

# belongs_to :from, class_name: "User", optional: true
# belongs_to :blocked, class_name: "User", optional: true
# validates :from_id, presence: true
# validates :blocked_id, presence: true
# validates :blocked_id, uniqueness: { scope: :from_id }
# validate :self_block

# block1 = FactoryBot.create(:block1, blocker_id: admin.id, blocked_id: blockuser.id)
