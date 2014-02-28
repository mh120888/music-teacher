class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :student_id
      t.string  :title
      t.text    :description
      t.date :date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
