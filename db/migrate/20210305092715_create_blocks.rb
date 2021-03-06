# frozen_string_literal: true

class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.integer :blocker_id
      t.integer :blocked_id
      t.timestamps
    end
  end
end
