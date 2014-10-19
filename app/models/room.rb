# == Schema Information
#
# Table name: rooms
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  join_token     :string(255)
#  owner_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  playlist_items :integer          default([]), is an Array
#  github_token   :string(255)
#
# Indexes
#
#  index_rooms_on_owner_id  (owner_id)
#

class Room < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :owner, :name, presence: true
  validates :name,
            format: { with: /\A^[-_a-z0-9]+$\z/ },
            uniqueness: true

  before_create :set_auth_token

  alias_method :members, :users

  def active_members
    members.where active_room: self
  end

  def set_auth_token
    generate_token(:join_token)
    generate_token(:github_token)
  end

  def generate_token(field)
    return if send(field).present?
    loop { break unless self.class.exists?(field => send("#{field}=", SecureRandom.hex)) }
  end
end
