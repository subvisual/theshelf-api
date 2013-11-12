class UsersController < Clearance::UsersController
  before_action :handle_disabled_signup, only: [:new, :create]

  def create
  end

  def handle_disabled_signup
    redirect_to sign_in_path, notice: t('flashes.signup_disabled')
  end
end
