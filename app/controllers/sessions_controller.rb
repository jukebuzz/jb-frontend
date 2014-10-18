class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    @user = Users::Creator.new(auth: auth).call
    sign_in @user

    redirect_to '/auth_success.html'
  end

  def destroy
    sign_out
    head :no_content
  end

  def failure
    redirect_to '/auth_fail.html'
  end
end
