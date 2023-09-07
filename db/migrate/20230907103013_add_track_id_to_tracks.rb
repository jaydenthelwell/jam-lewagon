class AddTrackIdToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :top_tracks, :spotify_ref, :string
  end
end
