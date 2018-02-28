class AddLocationToRainwork < ActiveRecord::Migration[5.2]
  def change
  	add_column :rainworks, :lat, :float
  	add_column :rainworks, :lng, :float
  end
end
