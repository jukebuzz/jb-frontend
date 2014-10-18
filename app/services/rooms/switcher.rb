module Rooms
  class Switcher
    attr_reader :user

    def initialize(options)
      options.each do |k, v|
        instance_variable_set "@#{k}", v
      end
    end

    def call
      user.update_attributes active_room: room
    end

    private

    def room
      @room ? user.rooms.find(@room.id) : nil
    end
  end
end
