module Rooms
  class Leaver < Service
    attr_reader :member, :room

    def call
      Switcher.new(user: member, room: nil).call if member.active_room == room
      Membership.find_by!(user: member, room: room).destroy
    end
  end
end
