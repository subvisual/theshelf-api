class UsersController < Clearance::UsersController
  before_action :handle_disabled_signup, only: [:new, :create]

  def create
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :first_name, :last_name, :avatar, :avatar_cache)
  end

  def handle_disabled_signup
    redirect_to log_in_path, notice: t('flashes.signup_disabled')
  end
end
