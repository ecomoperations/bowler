class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
    	t.belongs_to :bowl
    	t.integer :first_try
    	t.integer :second_try
    	t.integer :frame_score

      t.timestamps
    end
  end
end
