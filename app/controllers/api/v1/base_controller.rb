module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      private

      def render_not_found
        render json: {
          error: "Not found"
        }, status: :not_found

      end
    end
  end
end
