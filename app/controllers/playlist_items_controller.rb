class PlaylistItemsController < ApplicationController
  before_action :authenticate
  before_action :room
  before_action :playlist

  def index
  end

  def create
    playlist_manager.append_soundcloud_track(track_params[:soundcloud_id])

    render :index
  end

  def destroy
    playlist_manager.delete_track(params[:id].to_i)

    render :index
  end

  def move_up
    playlist_manager.move_up_track(params[:id].to_i)

    render :index
  end

  def move_down
    playlist_manager.move_down_track(params[:id].to_i)

    render :index
  end

  private

  def playlist_manager
    PlaylistManager.new(playlist)
  end

  def room
    @room ||= current_user.rooms.find(params[:playlist_id])
  end

  def playlist
    @playlist ||= Playlist.new(room)
  end

  private

  def track_params
    params.require(:track).permit(:soundcloud_id)
  end
end
