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

      # necessary to return the right content type and response body
      ActionController::Renderers.add :json_v1 do |resource, options|
        self.content_type = Mime::JSON_V1
        self.response_body = _render_option_json(resource, options)
      end

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
          format.json_v1 { render json_v1: 'Bad credentials', status: :unauthorized }
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
