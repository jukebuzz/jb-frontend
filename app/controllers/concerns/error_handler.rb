module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from AuthorizationError, with: :unauthorized
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :bad_request
    rescue_from BadRequest, with: :bad_request
  end

  class BadRequest < StandardError
  end

  class AuthorizationError < StandardError
  end

  def unsigned
    render json: construct_error_message('AuthorizationError', 'Signed request provided is not valid'),
           status: :unauthorized
  end

  def unauthorized
    render json: construct_error_message('AuthorizationError', 'Unauthorized request'),
           status: :unauthorized
  end

  def bad_request
    render json: construct_error_message('RequestError', 'Something wrong with your request'),
           status: :bad_request
  end

  private

  def construct_error_message(error_type, error_message)
    { error: { error_type: error_type, error_message: error_message } }
  end
end
