class ApiController < ApplicationController
  before_action :authenticate

  protect_from_forgery unless: -> { request.format.json? }

  def authenticate
    render json: { error: 'Unauthorized' }, status: 401 unless current_user.present?
  end

  def render_client_errors(errors, status = :bad_request)
    errors = [errors] unless errors.is_a?(Array)
    render json: {
      success: false,
      errors: errors
    }, status: status
  end
end
