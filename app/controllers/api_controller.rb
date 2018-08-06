class ApiController < ApplicationController
  before_action :authenticate

  protect_from_forgery unless: -> { request.format.json? }

  def authenticate
    render json: { error: 'Unauthorized' }, status: 401 unless current_user.present?
  end
end
