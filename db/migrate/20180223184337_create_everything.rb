class CreateEverything < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :device_uuid
      t.string :push_token

      t.timestamps
    end

    add_index :devices, :device_uuid

    create_table :rainworks do |t|
      t.string :name
      t.string :creator_name
      t.string :creator_email
      t.text :description
      t.text :image_url
      t.integer :approval_status
      t.boolean :active
      t.float :lat
      t.float :lng
      t.belongs_to :device, foreign_key: true

      t.timestamps
    end

    create_table :reports do |t|
      t.belongs_to :device, foreign_key: true
      t.belongs_to :rainwork, foreign_key: true
      t.integer :report_type

      t.timestamps
    end

    add_index :reports, [:report_type, :device_id, :rainwork_id], unique: true
  end
end
