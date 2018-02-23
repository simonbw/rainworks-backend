class CreateRainworks < ActiveRecord::Migration[5.2]
  def change
    create_table :rainworks do |t|
      t.string :name
      t.string :creator_name
      t.string :creator_email
      t.text :description
      t.text :image_url
      t.integer :approval_status
      t.boolean :active

      t.timestamps
    end
  end
end
