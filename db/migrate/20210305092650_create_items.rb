class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :cordinate_id
      t.integer :super_item
      t.integer :season
      t.integer :tpo
      t.integer :color
      t.integer :content
      t.text :memo
      t.string :picture
      t.float :rating

      t.timestamps
    end
  end
end
