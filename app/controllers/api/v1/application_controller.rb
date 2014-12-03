module API
  module V1
    class ApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::MimeResponds
      include ActionController::Serialization
      include CanCan::ControllerAdditions

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      before_action :authenticate

      check_authorization

      private

      def authenticate
        authenticate_user_from_token! || unauthorized
      end

      def authenticate_user_from_token!
        authenticate_with_http_token do |token|
          user = User.where(authentication_token: token).first

          if user
            sign_in user, store: false
          end
        end
      end

      def unauthorized
        headers['WWW-Authenticate'] = 'Token realm="Application"'

        respond_to do |format|
          format.json { render json: 'Bad credentials', status: :unauthorized }
        end
      end

      def record_not_found
        head :not_found
      end

      def parameter_missing
        head :bad_request
      end
    end
  end
end
