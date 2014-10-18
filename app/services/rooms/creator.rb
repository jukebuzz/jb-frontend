module Rooms
  class Creator < Service
    attr_reader :owner, :name, :room

    def call
      @room = Room.create name: name, owner: owner
      if room.persisted?
        # TODO: use joiner service object
        Membership.create(user: owner, room: room)
        Switcher.new(user: owner, room: room).call
      end

      room
    end
  end
end
