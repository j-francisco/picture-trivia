class CreateUserGame < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
    	t.integer :user_id, null: false
    	t.integer :game_id, null: false
    	t.integer :score
    	t.datetime :started_at
    	t.datetime :finished_at

    	t.timestamps
    end
  end
end
