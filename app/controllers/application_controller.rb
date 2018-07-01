class ApplicationController < ActionController::Base
  include Pundit

  before_action :current_business
  before_action :set_time_zone
  before_action :switch_business_for_admin
  after_action :verify_authorized, except: :index, unless: :active_admin_controller?
  after_action :verify_policy_scoped, only: :index, unless: :active_admin_controller?

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController) || is_a?(ActiveAdmin::Devise::SessionsController)
  end

  def current_business
    return nil if request.subdomain.nil?
    @current_business ||= Business.find_by_subdomain(request.subdomain)
  end
  helper_method :current_business

  def set_time_zone
    Time.zone = current_business.time_zone if current_business.present?
  end

  def switch_business_for_admin
    if current_user.present? && current_user.super_admin? && current_user.business != current_business
      current_user.update(business: current_business)
    end
  end
end
