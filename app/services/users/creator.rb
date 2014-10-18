module Users
  class Creator < Service
    attr_reader :auth, :user

    def call
      @user = User.find_or_create_with_omniauth auth
      join_demo_rooms

      user
    end

    private

    def join_demo_rooms
      demo_rooms = Room.where(name: DefaultRooms.list)
      demo_rooms.each do |room|
        Rooms::Joiner.new(user: user, room: room).call
      end
    end
  end
end
