class ApplicationController < ActionController::Base
  include Authenticatable
  include ErrorHandler

  protect_from_forgery with: :null_session
end
