class RemoveSwipeFromMatch < ActiveRecord::Migration[7.0]
  def change
    remove_reference :matches, :swipe
  end
end
