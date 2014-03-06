class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :access_token
      t.integer :user_id
    end
  end
end
