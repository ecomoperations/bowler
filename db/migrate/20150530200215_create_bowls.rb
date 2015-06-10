class CreateBowls < ActiveRecord::Migration
  def change
    create_table :bowls do |t|
      t.integer :score
      t.integer :turn
      t.integer :total_score	

      t.timestamps
    end
  end
end
