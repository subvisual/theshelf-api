module V1
  class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

    def record_not_found
      head :not_found
    end
  end
end
