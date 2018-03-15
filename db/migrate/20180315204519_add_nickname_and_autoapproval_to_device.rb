class AddNicknameAndAutoapprovalToDevice < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :nickname, :string
  	add_column :devices, :initial_submission_status, :integer
  end
end
