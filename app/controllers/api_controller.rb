class ApiController < ApplicationController
  include ApiResponsable

  before_action :authenticate
  skip_before_action :verify_authenticity_token

  protect_from_forgery unless: -> { request.format.json? }

  def authenticate
    render json: { error: 'Unauthorized' }, status: 401 unless current_user.present?
  end
end
