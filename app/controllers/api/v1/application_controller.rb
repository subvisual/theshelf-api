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
      after_action :set_content_type

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
        set_content_type
        headers['WWW-Authenticate'] = 'Token realm="Application"'

        render json: 'Bad credentials', status: :unauthorized
      end

      def set_content_type
        headers['Content-Type'] = Mime::JSON_V1.to_s
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
