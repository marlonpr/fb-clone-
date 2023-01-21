class ChangeStatusToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :friendships, :status, :integer
  end
end
