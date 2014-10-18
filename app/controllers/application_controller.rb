class ApplicationController < ActionController::Base
  include Authenticatable
  include ErrorHandler

  protect_from_forgery with: :null_session unless Rails.env.development?
  after_filter :set_csrf_cookie

  def set_csrf_cookie
    cookies['CSRF-Token'] = form_authenticity_token if protect_against_forgery?
  end
end
