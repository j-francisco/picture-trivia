class AddImgPublicIdToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :img_public_id, :string
  end
end
