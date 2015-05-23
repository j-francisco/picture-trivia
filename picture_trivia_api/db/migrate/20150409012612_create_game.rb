class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.string :name, null: false
    	t.integer :category_id
    	t.integer :question_ids, array: true, default: []

    	t.timestamps
    end
  end
end
