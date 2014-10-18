module Rooms
  class Leaver
    attr_reader :member, :room

    def initialize(options)
      options.each do |k, v|
        instance_variable_set "@#{k}", v
      end
    end

    def call
      Membership.find_by!(user: member, room: room).destroy
      Switcher.new(user: member, room: nil).call if member.active_room == room
    end
  end
end
