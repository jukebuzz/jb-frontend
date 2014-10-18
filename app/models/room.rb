# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  join_token :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_rooms_on_owner_id  (owner_id)
#

class Room < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :memberships
  has_many :users, through: :memberships

  validates :owner, :name, presence: true
  validates :name,
            format: { with: /\A^[-_a-z0-9]+$\z/ },
            uniqueness: true

  before_create :set_auth_token

  private

  def set_auth_token
    return if join_token.present?

    loop do
      self.join_token = SecureRandom.hex
      break unless self.class.exists?(join_token: join_token)
    end
  end
end