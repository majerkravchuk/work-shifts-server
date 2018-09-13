class ErrorSerializer < BaseSerializer
  set_type :error
  attributes :url, :messages, :http_method, :http_code, :http_message
end
