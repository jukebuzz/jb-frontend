class Soundcloud
  cattr_accessor :current
end
Soundcloud.current = Soundcloud.new(client_id: ENV['SOUNDCLOUD_CLIENT_ID'])
