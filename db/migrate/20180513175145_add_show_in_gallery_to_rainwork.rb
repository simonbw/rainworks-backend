class AddShowInGalleryToRainwork < ActiveRecord::Migration[5.2]
  def change
    add_column :rainworks, :show_in_gallery, :boolean
  end
end
