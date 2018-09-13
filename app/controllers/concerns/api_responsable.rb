module ApiResponsable
  extend ActiveSupport::Concern

  def render_client_errors(errors, status = :bad_request)
    errors = [errors] unless errors.is_a?(Array)

    error_object = {}.tap do |e|
      e[:id] = SecureRandom.uuid
      e[:url] = request.url
      e[:errors] = errors
      e[:code] = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      e[:message] = Rack::Utils::HTTP_STATUS_CODES[e[:code]]
    end

    render json: ErrorSerializer.new(OpenStruct.new(error_object)), status: status
  end
end
