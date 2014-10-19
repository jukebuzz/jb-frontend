json.array!(playlist.items) do |track|
  json.extract! track, :id, :soundcloud_id, :artwork_url, :stream_url, :duration, :title, :artist
end
