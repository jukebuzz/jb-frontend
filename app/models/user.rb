# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  uid        :string(255)
#  avatar_url :string(255)
#  created_at :datetime
#  updated_at :datetime
#  nickname   :string(255)
#

class User < ActiveRecord::Base
  has_many :memberships
  has_many :rooms, through: :memberships

  validates :nickname, :email, :uid, presence: true
  validates :uid, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    find_or_create_by uid: auth['uid'] do |user|
      user.name = auth[:info][:name]
      user.nickname = auth[:info][:nickname]
      user.email = auth[:info][:email]
      user.avatar_url = auth[:info][:image]
    end
  end
end
