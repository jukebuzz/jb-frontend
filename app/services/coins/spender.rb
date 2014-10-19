module Coins
  class Spender < Service
    attr_reader :user, :room

    def call(amount)
      if balance >= amount
        spend amount
        block_given? ? yield : true
      else
        false
      end
    end

    private

    def spend(amount)
      membership.present? && membership.increment!(:coins, -amount)
    end

    def balance
      membership.try(:coins).to_i
    end

    def membership
      @membership ||= user.memberships.find_by(room: room)
    end
  end
end
