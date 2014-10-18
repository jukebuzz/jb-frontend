module Rooms
  class Leaver < Service
    attr_reader :member, :room

    def call
      Membership.find_by!(user: member, room: room).destroy
      Switcher.new(user: member, room: nil).call if member.active_room == room
    end
  end
end
