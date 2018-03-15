class AddRejectionReasonToRainwork < ActiveRecord::Migration[5.2]
  def change
    add_column :rainworks, :rejection_reason, :text
  end
end
