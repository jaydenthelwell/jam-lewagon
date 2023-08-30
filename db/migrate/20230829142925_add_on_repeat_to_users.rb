class AddOnRepeatToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :on_repeat, :string
    add_column :users, :all_time_favorite, :string
    add_column :users, :go_to_karaoke, :string
  end
end
