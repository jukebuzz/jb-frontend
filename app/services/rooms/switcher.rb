module Rooms
  class Switcher < Service
    attr_reader :user

    def call
      user.update_attributes active_room: room
    end

    private

    def room
      @room ? user.rooms.find(@room.id) : nil
    end
  end
end
