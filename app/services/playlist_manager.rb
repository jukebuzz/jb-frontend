class PlaylistManager
  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def append_soundcloud_track(soundcloud_id)
    (track = soundcloud_track(soundcloud_id)).persisted? && playlist.append_track(track)
  end

  def prepend_soundcloud_track(soundcloud_id)
    (track = soundcloud_track(soundcloud_id)).persisted? && playlist.prepend_track(track)
  end

  delegate :delete_track, :move_up_track, :move_down_track, to: :playlist

  private

  def soundcloud_track(soundcloud_id)
    Track.find_or_create_by(soundcloud_id: soundcloud_id)
  end
end
