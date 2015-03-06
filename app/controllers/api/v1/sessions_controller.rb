module API
  module V1
    class SessionsController < ApplicationController
      skip_authorization_check

      skip_before_filter :authenticate

      def create
        if user.valid_password?(user_params[:password])
          render json: user, serializer: SessionSerializer
        else
          head :unauthorized
        end
      end

      private

      def user
        @_user ||= User.where(email: user_params[:email]).first || GuestUser.new
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
