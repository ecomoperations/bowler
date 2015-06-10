class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
    	t.string :name
      t.timestamps
    end
    add_column :bowls, :player_id, :integer
  end
end
