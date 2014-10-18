class AddPlaylistItemsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :playlist_items, :integer, array: true, default: []
  end
end
