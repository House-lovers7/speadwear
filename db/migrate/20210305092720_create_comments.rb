# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :cordinate_id
      t.string :comment

      t.timestamps
    end
  end
end
