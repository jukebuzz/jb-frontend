module Coins
  # User can earn coins only with upper limit
  class Earner < Service
    attr_reader :user, :room

    def call(count = 1)
      membership.present? && membership.increment!(:coins, count)
    end

    private

    def membership
      @membership ||= user.memberships.find_by(room: room)
    end
  end
end
