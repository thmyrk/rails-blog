module Api
  module V1
    class ApiController < ApplicationController
      rescue_from BaseUseCase::ParamValidationError, with: :bad_request
      rescue_from ActiveRecord::RecordInvalid, with: :bad_request
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def bad_request(response = {})
        render status: :bad_request, json: { errors: response }
      end

      def record_not_found(response = {})
        render status: :not_found, json: { errors: response }
      end
    end
  end
end
