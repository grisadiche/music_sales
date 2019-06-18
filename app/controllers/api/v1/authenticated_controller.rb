module Api
  module V1
    class AuthenticatedController < Api::V1::BaseController
      include BasicAuthentication
      rescue_from BasicAuthentication::Error, with: :render_unauthorized
      before_action :authenticate_user_from_token!

      private

      def render_unauthorized
        render json: {
          error: "You do not have the api credentials for this user"
        }, status: :unauthorized
      end
    end
  end
end
