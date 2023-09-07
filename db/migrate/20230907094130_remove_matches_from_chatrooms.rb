class RemoveMatchesFromChatrooms < ActiveRecord::Migration[7.0]
  def change
    remove_reference :chatrooms, :match
    add_reference :chatrooms, :swipe, foreign_key: true
  end
end
