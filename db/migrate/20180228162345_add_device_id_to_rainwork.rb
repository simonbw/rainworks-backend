class AddDeviceIdToRainwork < ActiveRecord::Migration[5.2]
  def change
    add_column :rainworks, :device_id, :string
  end
end
