class ChangeDatatypeRatingOfItems < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :rating, :integer
  end
  end
