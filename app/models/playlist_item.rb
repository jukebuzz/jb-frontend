# == Schema Information
#
# Table name: playlist_items
#
#  id         :integer          not null, primary key
#  track_id   :integer
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  played_at  :datetime
#

class PlaylistItem < ActiveRecord::Base
  belongs_to :track
  belongs_to :owner, class_name: User

  delegate :soundcloud_id, :artwork_url, :stream_url, :duration, :title, :artist, to: :track

  def played!
    touch(:played_at)
  end
end
