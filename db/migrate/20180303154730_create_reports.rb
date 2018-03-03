class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :report_type
      t.references :device, foreign_key: true
      t.references :rainwork, foreign_key: true

      t.timestamps
    end

    add_index :reports, [:report_type, :device_id, :rainwork], unique: true
  end
end
