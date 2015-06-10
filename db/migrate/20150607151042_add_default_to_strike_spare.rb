class AddDefaultToStrikeSpare < ActiveRecord::Migration
  def change
  	change_column :bowls, :strike_spare, :integer, :default => 0
  end
end
