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
end
