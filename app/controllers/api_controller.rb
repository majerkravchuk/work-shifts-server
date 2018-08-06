class ApiController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  protect_from_forgery unless: -> { request.format.json? }
end
