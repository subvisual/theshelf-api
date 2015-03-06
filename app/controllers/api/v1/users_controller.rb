module API
  module V1
    class UsersController < ApplicationController
      skip_authorization_check

      skip_before_filter :authenticate

      def index
        render json: User.all
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user
        else
          head :bad_request
        end
      end

      def show
        render json: User.find(params[:id])
      end

      private

      def user_params
        params.permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end
