class AddProfileToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :profile, foreign_key: true, null: true
  end
end
