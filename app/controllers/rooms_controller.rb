class RoomsController < ApplicationController
  before_action :authenticate

  def index
    @rooms = current_user.rooms
  end

  def create
    @room = RoomCreator.new(room_params).call

    if @room.persisted?
      render :show, status: :created
    else
      fail BadRequest, @room.errors.messages
    end
  end

  def join
    @room = Room.find_by!(join_room_params)

    membership = Membership.new(user: current_user, room: @room)
    !membership.save && fail(BadRequest, membership.errors.messages)

    render :show
  end

  def left
    @room = Room.find(params[:id])
    RoomLefter.new(member: current_user, room: @room).call

    head :no_content
  end

  def destroy
    current_user.acquired_rooms.find(params[:id]).destroy
    head :no_content
  end

  private

  def room_params
    params.require(:room).permit(:name).merge(owner: current_user)
  end

  def join_room_params
    params.require(:room).permit(:join_token)
  end
end
