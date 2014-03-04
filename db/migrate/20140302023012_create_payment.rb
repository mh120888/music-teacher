class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :payment_profile_id
    end
  end
end
