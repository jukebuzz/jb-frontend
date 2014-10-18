# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  email          :string(255)
#  uid            :string(255)
#  avatar_url     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  nickname       :string(255)
#  active_room_id :integer
#
# Indexes
#
#  index_users_on_active_room_id  (active_room_id)
#

class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :rooms, through: :memberships
  has_many :acquired_rooms, class_name: 'Room', foreign_key: 'owner_id', dependent: :destroy
  belongs_to :active_room, class_name: 'Room'

  validates :uid, presence: true, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    find_or_create_by uid: auth['uid'] do |user|
      user.name = auth[:info][:name]
      user.nickname = auth[:info][:nickname]
      user.email = auth[:info][:email]
      user.avatar_url = auth[:info][:image]
    end
  end
end
