module V1
  class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    private

    def record_not_found
      head :not_found
    end

    def parameter_missing
      head :bad_request
    end
  end
end
