class AddThumbnailUrlToRainwork < ActiveRecord::Migration[5.2]
  def change
    add_column :rainworks, :thumbnail_url, :string
  end
end
