class UsersController < Clearance::UsersController
  layout 'simple'
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :first_name, :last_name, :avatar, :avatar_cache, :remove_avatar)
  end
end
