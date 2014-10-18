class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :soundcloud_id

      t.timestamps
    end
  end
end
