class CreateAnswer < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.string :text, null: false
    	t.integer :question_id

    	t.timestamps
    end
  end
end
