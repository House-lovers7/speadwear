# frozen_string_literal: true

class CreateCordinates < ActiveRecord::Migration[5.1]
  def change
    create_table :cordinates do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :comment_id
      t.integer :likecordinate_id
      t.integer :season
      t.integer :tpo
      t.string :picture
      t.integer :si_shoes
      t.integer :si_bottoms
      t.integer :si_tops
      t.integer :si_outer
      t.text :memo
      t.float :rating
      t.timestamps
    end
  end
end
