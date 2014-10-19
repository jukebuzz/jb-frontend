module Rooms
  class GithubIntegrator < Service
    attr_reader :room, :params

    def call
      params[:commits].each do |commit|
        user = User.find_by(nickname: commit[:author].try(:[], :username))
        user && Coins::Earner.new(room: room, user: user).call(Settings.coins.rewards.commit)
      end
    end
  end
end
