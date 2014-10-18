class RoomCreator
  attr_reader :owner, :room_name, :room

  def initialize(options)
    options.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def call!
    ActiveRecord::Base.transaction do
      @room = Room.create! name: room_name, owner: owner
      Membership.create!(user: owner, room: room)
    end

    room
  end
end
