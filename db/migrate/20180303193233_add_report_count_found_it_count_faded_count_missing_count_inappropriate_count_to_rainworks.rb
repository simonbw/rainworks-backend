class AddReportCountFoundItCountFadedCountMissingCountInappropriateCountToRainworks < ActiveRecord::Migration[5.2]
  def self.up
    add_column :rainworks, :report_count, :integer, null: false, default: 0
    add_column :rainworks, :found_it_count, :integer, null: false, default: 0
    add_column :rainworks, :faded_count, :integer, null: false, default: 0
    add_column :rainworks, :missing_count, :integer, null: false, default: 0
    add_column :rainworks, :inappropriate_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :rainworks, :report_count
    remove_column :rainworks, :found_it_count
    remove_column :rainworks, :faded_count
    remove_column :rainworks, :missing_count
    remove_column :rainworks, :inappropriate_count
  end
end
