class ApplicationController < ActionController::Base
  include Pundit

  before_action :check_current_user_business
  before_action :current_business
  before_action :set_time_zone
  before_action :set_gon_available_businesses

  def check_current_user_business
    current_user.update(business: Business.first) if current_user.present? && current_user.business.nil?
  end

  def current_business
    return nil if current_user.nil?
    @current_business ||= current_user.business
  end
  helper_method :current_business

  def set_gon_available_businesses
    return unless is_a?(ActiveAdmin::BaseController)
    businesses = current_user.admin? ? Business.all : current_user.businesses
    gon.availableBusinesses = businesses.map { |business| { id: business.id, name: business.name } }
  end

  def set_time_zone
    Time.zone = current_business.time_zone if current_business.present?
  end
end
