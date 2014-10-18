module Rooms
  class Creator < Service
    attr_reader :owner, :name, :room

    def call
      @room = Room.new name: name, owner: owner
      room.save && Joiner.new(user: owner, room: room).call

      room
    end
  end
end
