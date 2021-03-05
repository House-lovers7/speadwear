class CreateLikecordinates < ActiveRecord::Migration[5.1]
  def change
    create_table :likecordinates do |t|
      t.integer :user_id
      t.integer :cordinate_id

      t.timestamps
    end
  end
end
