class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :join_token
      t.references :owner, index: true

      t.timestamps
    end
  end
end
