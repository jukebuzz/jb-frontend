module Rooms
  class Creator
    attr_reader :owner, :name, :room

    def initialize(options)
      options.each do |k, v|
        instance_variable_set "@#{k}", v
      end
    end

    def call
      @room = Room.create name: name, owner: owner
      if room.persisted?
        Membership.create(user: owner, room: room)
        Switcher.new(user: owner, room: room).call
      end

      room
    end
  end
end
