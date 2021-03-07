# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :cordinate_id
      t.integer :comment_id
      t.integer :likecordinate_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
