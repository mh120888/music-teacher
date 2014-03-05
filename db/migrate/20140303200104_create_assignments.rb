class CreateAssignments < ActiveRecord::Migration
  def change
  	create_table :assignments do |t|
  		t.integer :contact_id
  		t.string :description, :title
  		t.timestamps
  	end
  end
end
