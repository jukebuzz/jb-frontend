class PlaylistManager
  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def append_soundcloud_track(soundcloud_id)
    playlist.append_track(soundcloud_track(soundcloud_id))
  end

  def prepend_soundcloud_track(soundcloud_id)
    playlist.prepend_track(soundcloud_track(soundcloud_id))
  end

  delegate :delete_track, :move_up_track, :move_down_track, to: :playlist

  private

  def soundcloud_track(soundcloud_id)
    Track.find_or_create_by(soundcloud_id: soundcloud_id)
  end
end
