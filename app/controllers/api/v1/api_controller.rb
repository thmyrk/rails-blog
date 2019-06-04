module Api
  module V1
    class ApiController < ApplicationController
      rescue_from BaseUseCase::ParamValidationError, with: :bad_request
      rescue_from ActiveRecord::RecordInvalid, with: :bad_request

      def bad_request(response = {})
        render status: :bad_request, json: { errors: response }
      end
    end
  end
end
