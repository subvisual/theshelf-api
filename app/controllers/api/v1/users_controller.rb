module API
  module V1
    class UsersController < ApplicationController
      skip_before_filter :authenticate

      def create
        user = User.new user_params

        if user.save
          render json: user, root: false
        else
          head :bad_request
        end
      end

      def user_params
        params.permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end
