class AddReferencesToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :match
  end
end
