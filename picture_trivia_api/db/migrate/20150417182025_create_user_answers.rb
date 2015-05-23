class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
    	t.integer :user_game_id, null: false
    	t.integer :selected_answer_id, null: false
    	t.boolean :is_correct, null: false
    end
  end
end
