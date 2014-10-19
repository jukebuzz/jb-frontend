module Coins
  # User can get free coins only with upper limit
  class Giver < Earner
    def call(count = 1)
      count = [[max_balance - membership.coins, 0].max, count].min
      super count
    end

    private

    def max_balance
      Settings.coins.balance.max_given
    end
  end
end
