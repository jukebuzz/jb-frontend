# == Schema Information
#
# Table name: tracks
#
#  id            :integer          not null, primary key
#  soundcloud_id :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  artwork_url   :string(255)
#  stream_url    :string(255)
#  duration      :integer
#  title         :string(255)
#  artist        :string(255)
#

class Track < ActiveRecord::Base
  validates :soundcloud_id, presence: true, uniqueness: true
end
