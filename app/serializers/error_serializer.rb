class ErrorSerializer < BaseSerializer
  set_type :error
  attributes :url, :errors, :code, :message
end
