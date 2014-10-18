module Rooms
  class Joiner < Service
    attr_reader :user, :room

    def call
      membership = Membership.new(user: user, room: room)
      membership.save && Switcher.new(user: user, room: room).call

      membership
    end
  end
end
