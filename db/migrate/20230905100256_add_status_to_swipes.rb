class AddStatusToSwipes < ActiveRecord::Migration[7.0]
  def change
    add_column :swipes, :status, :integer, default: 0
  end
end
