class UpdateGame < ActiveRecord::Migration
  def change
  	add_column :games, :game_type, :integer, null: false, default: 1
  	add_column :games, :question_count, :integer, null: false, default: 1
  end
end
