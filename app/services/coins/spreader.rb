module Coins
  # User can earn coins only with upper limit
  class Spreader < Service
    attr_reader :room

    def call
      lucky_members.each_with_index do |member, index|
        Giver.new(user: member, room: room).call(spread_array[index])
      end
    end

    private

    def lucky_members
      members.sample(spreaded_coins_count)
    end

    def members
      @members ||= room.active_members
    end

    def spreaded_coins_count
      Settings.coins.hourly_spreaded
    end

    def spread_array
      @spread_array ||= calculate_spread_array(spreaded_coins_count, lucky_members.count)
    end

    # Fair way to spread some parts in
    def calculate_spread_array(amount, parts_count)
      result = []
      parts_count.times do |i|
        part = ((amount - result.inject(:+).to_i) / (parts_count - i)).ceil
        result << part
      end

      result
    end
  end
end
