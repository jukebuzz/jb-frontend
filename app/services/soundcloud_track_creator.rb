class SoundcloudTrackCreator < Service
  attr_reader :soundcloud_id

  def call
    Track.find_or_create_by(soundcloud_id: soundcloud_id) do |track|
      soundcloud_res = Soundcloud.current.get("/tracks/#{soundcloud_id}")

      track.artwork_url = soundcloud_res.artwork_url
      track.stream_url = soundcloud_res.stream_url
      track.duration = soundcloud_res.duration
      track.title = soundcloud_res.title
      track.artist = soundcloud_res.try(:user).try(:username)
    end
  end
end
