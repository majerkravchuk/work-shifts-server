class ApplicationController < ActionController::Base
  include Pundit

  before_action :current_business
  before_action :set_time_zone
  before_action :switch_business_for_admin

  def current_business
    return nil if params[:business].blank?
    @current_business ||= Business.find_by_scope(params[:business])
  end
  helper_method :current_business

  def set_time_zone
    Time.zone = current_business.time_zone if current_business.present?
  end

  def switch_business_for_admin
    if current_user.present? && current_user.administrator? && current_user.business != current_business
      current_user.update(business: current_business)
    end
  end
end
