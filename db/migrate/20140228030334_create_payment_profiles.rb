class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.string :access_token
      t.string :publishable_key

      t.timestamps
    end
  end
end
