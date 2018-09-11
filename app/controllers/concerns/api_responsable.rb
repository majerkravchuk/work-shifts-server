module ApiResponsable
  extend ActiveSupport::Concern

  def render_client_errors(errors, status = :bad_request)
    errors = [errors] unless errors.is_a?(Array)
    render json: {
      success: false,
      errors: errors
    }, status: status
  end
end
