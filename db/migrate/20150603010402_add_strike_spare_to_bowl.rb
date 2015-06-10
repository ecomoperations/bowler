class AddStrikeSpareToBowl < ActiveRecord::Migration
  def change
  	add_column :bowls, :strike_spare, :integer
  end
end
