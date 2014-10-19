namespace :coins do
  desc 'Spread hourly quota coins between all rooms active members'
  task spread: :environment do
    Room.all.each do |room|
      Coins::Spreader.new(room: room).call
    end
  end
end
