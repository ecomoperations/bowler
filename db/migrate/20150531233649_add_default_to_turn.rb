class AddDefaultToTurn < ActiveRecord::Migration
  def change
  	change_column :bowls, :turn, :integer, :default => 0
  end
end
