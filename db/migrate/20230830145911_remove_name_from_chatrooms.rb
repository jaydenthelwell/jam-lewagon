class RemoveNameFromChatrooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :chatrooms, :name, :string
  end
end
