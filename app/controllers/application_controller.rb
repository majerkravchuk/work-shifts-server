class ApplicationController < ActionController::Base
  before_action :current_business

  def current_business
    return nil if request.subdomain.nil?
    @current_business ||= Business.find_by_subdomain(request.subdomain)
  end
end
