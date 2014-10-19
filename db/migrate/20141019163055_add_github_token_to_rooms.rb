class AddGithubTokenToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :github_token, :string

    Room.reset_column_information
    Room.find_each { |room| room.set_auth_token; room.save! }
  end
end
