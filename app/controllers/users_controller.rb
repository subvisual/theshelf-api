class UsersController <  ApplicationController
  layout 'simple', only: 'new'

  def create
    @user = User.new user_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render :new, layout: 'simple'
    end
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
    params.require(:user).permit(:email, :password, :first_name, :last_name, :avatar, :avatar_cache, :remove_avatar)
  end
end
