# == Schema Information
#
# Table name: tracks
#
#  id            :integer          not null, primary key
#  soundcloud_id :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Track < ActiveRecord::Base
  validates :soundcloud_id, presence: true, uniqueness: true
end
