class PlaylistManager < Service
  attr_reader :playlist, :user

  def append_soundcloud_track(soundcloud_id)
    Coins::Spender.new(user: user, room: playlist.room).call(Settings.coins.pricing_plan.append) do
      (track = soundcloud_track(soundcloud_id)).persisted? && playlist.append_track(track, user)
    end || (fail ApplicationController::NotEnoughCoins)
  end

  def prepend_soundcloud_track(soundcloud_id)
    Coins::Spender.new(user: user, room: playlist.room).call(Settings.coins.pricing_plan.prepend) do
      (track = soundcloud_track(soundcloud_id)).persisted? && playlist.prepend_track(track, user)
    end || (fail ApplicationController::NotEnoughCoins)
  end

  def delete_track(*args)
    Coins::Spender.new(user: user, room: playlist.room).call(Settings.coins.pricing_plan.delete) do
      playlist.delete_track(*args)
    end || (fail ApplicationController::NotEnoughCoins)
  end

  def move_up_track(*args)
    Coins::Spender.new(user: user, room: playlist.room).call(Settings.coins.pricing_plan.move_up) do
      playlist.move_up_track(*args)
    end || (fail ApplicationController::NotEnoughCoins)
  end

  def move_down_track(*args)
    Coins::Spender.new(user: user, room: playlist.room).call(Settings.coins.pricing_plan.move_down) do
      playlist.move_down_track(*args)
    end || (fail ApplicationController::NotEnoughCoins)
  end

  private

  def soundcloud_track(soundcloud_id)
    SoundcloudTrackCreator.new(soundcloud_id: soundcloud_id).call
  end
end
