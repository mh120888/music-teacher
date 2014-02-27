class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.string :name
    end
  end
end
