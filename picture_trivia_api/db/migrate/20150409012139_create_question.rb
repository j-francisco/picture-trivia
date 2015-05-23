class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string :text, null: false
    	t.integer :correct_answer_id, null: false
    	t.string :img_src
    	t.integer :category_id

      	t.timestamps
    end
  end
end
