module Authenticatable
  extend ActiveSupport::Concern

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.present? ? user.id : user
  end

  def sign_in(user)
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
  end

  def authenticate
    signed_in? || fail(ErrorHandler::AuthorizationError)
  end
end
