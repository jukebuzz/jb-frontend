class AddActiveRoomToUser < ActiveRecord::Migration
  def change
    add_reference :users, :active_room, index: true
  end
end
