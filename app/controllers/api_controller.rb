class ApiController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  protect_from_forgery unless: -> { request.format.json? }

  def logged_in?
    current_user.present?
  end

  def current_user
    return @current_user if @current_user.present?
    @current_user = User.find_by auth['user']['id'] if auth_present?
    @current_user
  end

  def authenticate
    render json: { error: 'Unauthorized' }, status: 401 unless logged_in?
  end

  private

  def token
    request.env['HTTP_AUTHORIZATION'].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    request.env.fetch('HTTP_AUTHORIZATION', '').scan(/Bearer/).flatten.first.present?
  end
end
