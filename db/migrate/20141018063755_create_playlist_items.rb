class CreatePlaylistItems < ActiveRecord::Migration
  def change
    create_table :playlist_items do |t|
      t.integer :track_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
