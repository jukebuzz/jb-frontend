class AddTrackDataToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :artwork_url, :string
    add_column :tracks, :stream_url, :string
    add_column :tracks, :duration, :integer
    add_column :tracks, :title, :string
    add_column :tracks, :artist, :string
  end
end
