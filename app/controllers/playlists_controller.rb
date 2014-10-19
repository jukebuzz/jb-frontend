class PlaylistsController < ApplicationController
  before_action :authenticate
  before_action :room
  before_action :playlist
  before_action :authenticate_owner

  def next
    @playlist.next_track
    render :show
  end

  private

  def authenticate_owner
    fail RoomOwnerAccessRequired if playlist.owner_id != current_user.id
  end

  def room
    @room ||= current_user.rooms.find(params[:id])
  end

  def playlist
    @playlist ||= Playlist.new(room)
  end
end
