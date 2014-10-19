module Coins
  # User can earn coins only with upper limit
  class Earner < Service
    attr_reader :user, :room, :membership

    def initialize(options)
      super
      @membership = user.memberships.find_by(room: room)
    end

    def call(count = 1)
      membership.present? && membership.increment!(:coins, count)
    end
  end
end
