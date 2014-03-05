class AddStudentIdToPayments < ActiveRecord::Migration
  def change
  	add_column :payments, :student_id, :integer
  end
end
