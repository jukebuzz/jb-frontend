class UsersController < ApplicationController
  before_action :authenticate

  def show
    @user = User.find(params[:id])
  end

  def current
    @user = current_user
    render :show
  end
end
