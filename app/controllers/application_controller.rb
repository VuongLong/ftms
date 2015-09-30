class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :set_locale

  include ApplicationHelper
  include PublicActivity::StoreController

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to main_app.root_path
  end

  def default_url_options options = {}
    {locale: I18n.locale}
  end

  def after_sign_in_path_for resource
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      (current_user.role==0 ||current_user.role==1) ? 
        rails_admin.dashboard_path : root_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  private
  def after_sign_in_path_for user
    user.trainee? ? root_path : rails_admin_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    User.human_attribute_name "name"
    User.human_attribute_name "email"
    User.human_attribute_name "password"
    User.human_attribute_name "password_confirmation"
  end
end
