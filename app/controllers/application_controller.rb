class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to log_in_path, :alert => exception.message
    end
  end

  def presented_current_user
    UserDecorator.decorate(current_user) if current_user
  end

  def url_after_denied_access_when_signed_out
    log_in_url
  end

  helper_method :presented_current_user
end
