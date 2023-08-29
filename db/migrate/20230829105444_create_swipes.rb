class CreateSwipes < ActiveRecord::Migration[7.0]
  def change
    create_table :swipes do |t|
      t.references :swiper, foreign_key: {to_table: :users}
      t.references :swipee, foreign_key: {to_table: :users}
      t.boolean :like

      t.timestamps
    end


  end
end
