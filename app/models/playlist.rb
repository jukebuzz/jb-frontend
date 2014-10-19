class Playlist
  include Decorator

  attr_reader :room

  def initialize(room)
    super(room)

    @room = room
  end

  def append_track(track, user)
    playlist_items.push(create_playlist_item(track, user).id)
    playlist_items_will_change_and_save
  end

  def prepend_track(track, user)
    playlist_items.unshift(create_playlist_item(track, user).id)
    playlist_items_will_change_and_save
  end

  def delete_track(id)
    playlist_items.delete(id)
    playlist_items_will_change_and_save
  end

  def move_up_track(id)
    playlist_items.tap do |pi|
      index = pi.find_index(id)
      pi.insert(index == 0 ? 0 : index - 1, pi.delete_at(index)).compact!
    end
    playlist_items_will_change_and_save
  end

  def move_down_track(id)
    playlist_items.tap do |pi|
      index = pi.find_index(id)
      pi.insert(index + 1, pi.delete_at(index)).compact!
    end
    playlist_items_will_change_and_save
  end

  def next_track
    (playlist_item_id = playlist_items.shift) && PlaylistItem.find(playlist_item_id).played!
    playlist_items_will_change_and_save
  end

  def items
    # TODO: optimize
    playlist_items.map { |id| PlaylistItem.find(id) }
  end

  private

  def create_playlist_item(track, owner)
    PlaylistItem.create(track: track, owner: owner)
  end

  def playlist_items_will_change_and_save
    playlist_items_will_change!
    save
  end
end
