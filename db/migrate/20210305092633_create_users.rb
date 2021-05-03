# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.integer :cordinate_id
      t.integer :item_id
      t.integer :comment_id
      t.boolean :admin
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.timestamps
    end
  end
end
