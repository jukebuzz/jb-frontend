# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  coins      :integer          default(0)
#
# Indexes
#
#  index_memberships_on_room_id  (room_id)
#  index_memberships_on_user_id  (user_id)
#

class Membership < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  validates :room, :user, presence: true
  validates :room, uniqueness: { scope: :user }
  validates :coins, numericality: { greater_than_or_equal_to: 0 }
end
