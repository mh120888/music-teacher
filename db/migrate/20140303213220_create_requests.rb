class CreateRequests < ActiveRecord::Migration
  def change
  	create_table :requests do |t|
  		t.string :description
  		t.string :title
  		t.integer :contact_id
  		t.timestamps
  	end
  end
end
