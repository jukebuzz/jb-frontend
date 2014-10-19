module Rooms
  class Creator < Service
    attr_reader :owner, :name, :room

    def call
      @room = Room.new name: name, owner: owner
      if room.save
        Joiner.new(user: owner, room: room).call
        reward
      end

      room
    end

    private

    def reward
      Coins::Earner.new(user: owner, room: room).call(Settings.coins.rewards.create)
    end
  end
end
