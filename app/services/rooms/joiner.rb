module Rooms
  class Joiner < Service
    attr_reader :user, :room

    def call
      membership = Membership.new(user: user, room: room)
      if membership.save
        Switcher.new(user: user, room: room).call
        reward
      end

      membership
    end

    private

    def reward
      Coins::Earner.new(user: user, room: room).call(Settings.coins.rewards.join)
    end
  end
end
