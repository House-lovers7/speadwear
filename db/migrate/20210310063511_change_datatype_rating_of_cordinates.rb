class ChangeDatatypeRatingOfCordinates < ActiveRecord::Migration[5.1]
  def change
    change_column :cordinates, :rating, :integer
  end
end

