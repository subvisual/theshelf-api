class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to sign_in_path, :alert => exception.message
    end
  end
  
  def presented_current_user
    UserDecorator.decorate(current_user) if current_user 
  end
  helper_method :presented_current_user
end
