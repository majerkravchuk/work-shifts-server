module ApiResponsable
  extend ActiveSupport::Concern

  def render_message(message, status = :ok)
    message_object = {}.tap do |e|
      e[:id] = SecureRandom.uuid
      e[:text] = message
    end

    render json: MessageSerializer.new(OpenStruct.new(message_object)), status: status
  end

  def render_client_errors(errors, status = :bad_request)
    errors = [errors] unless errors.is_a?(Array)

    error_object = {}.tap do |e|
      e[:id] = SecureRandom.uuid
      e[:url] = request.url
      e[:messages] = errors
      e[:http_method] = request.method
      e[:http_code] = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      e[:http_message] = Rack::Utils::HTTP_STATUS_CODES[e[:http_code]]
    end

    render json: ErrorSerializer.new(OpenStruct.new(error_object)), status: status
  end
end
