class AddDeviceIdToRainwork < ActiveRecord::Migration[5.2]
  def change
    add_column :rainworks, :installation_date, :datetime
  end
end
