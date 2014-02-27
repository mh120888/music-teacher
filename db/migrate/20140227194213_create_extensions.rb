class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.integer :user_id, :extension_id
    end
  end
end
