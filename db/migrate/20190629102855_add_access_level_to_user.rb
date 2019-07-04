class AddAccessLevelToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_level, :integer, null: false, default: 1
  end
end
