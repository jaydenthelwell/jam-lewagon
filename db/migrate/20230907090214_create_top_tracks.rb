class CreateTopTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :top_tracks do |t|
      t.string :track
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
