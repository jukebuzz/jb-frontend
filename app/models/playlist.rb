class Playlist
  attr_reader :room
  def initialize(room)
    @room = room
  end

  def append_track(track)
    @room.playlist_items.push(PlaylistItem.create(track: track).id)
    playlist_items_will_change_and_save
  end

  def prepend_track(track)
    @room.playlist_items.unshift(PlaylistItem.create(track: track).id)
    playlist_items_will_change_and_save
  end

  def delete_track(id)
    @room.playlist_items.delete(id)
    playlist_items_will_change_and_save
  end

  def move_up_track(id)
    @room.playlist_items.tap do |pi|
      index = pi.find_index(id)
      pi.insert(index == 0 ? 0 : index - 1, pi.delete_at(index)).compact!
    end
    playlist_items_will_change_and_save
  end

  def move_down_track(id)
    @room.playlist_items.tap do |pi|
      index = pi.find_index(id)
      pi.insert(index + 1, pi.delete_at(index)).compact!
    end
    playlist_items_will_change_and_save
  end

  def items
    # TODO: optimize
    @room.playlist_items.map { |id| PlaylistItem.find(id) }
  end

  private

  def playlist_items_will_change_and_save
    @room.playlist_items_will_change!
    @room.save
  end
end
