class AddPlayedAtPlaylistItems < ActiveRecord::Migration
  def change
    add_column :playlist_items, :played_at, :datetime
  end
end
