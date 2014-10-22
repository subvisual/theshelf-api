module V1
  class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    before_filter :authenticate_user_from_token!

    private

    def authenticate_user_from_token!
      if request.env['USER_TOKEN']
        user = User.where(authentication_token: request.env['USER_TOKEN']).first

        if user
          sign_in user, store: false
        end
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
