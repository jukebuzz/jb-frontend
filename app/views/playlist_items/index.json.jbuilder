json.array!(@playlist.items) do |track|
  json.extract! track, :id, :soundcloud_id
end
