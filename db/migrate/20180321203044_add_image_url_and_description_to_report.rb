class AddImageUrlAndDescriptionToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :image_url, :string
    add_column :reports, :description, :text
  end
end
