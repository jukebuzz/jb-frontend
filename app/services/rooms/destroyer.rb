module Rooms
  class Destroyer < Service
    attr_reader :owner, :room

    def call
      Switcher.new(user: owner, room: nil).call if owner.active_room == room
      owner.acquired_rooms.find(room.id).destroy
    end
  end
end
