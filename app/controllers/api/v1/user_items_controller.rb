module Api
  module V1
    class UserItemsController < AuthenticatedController
      def index
        render json: {
          status: :ok,
          data: Api::V1::ItemsPresenter.new(current_user.items).present
        }
      end

      def show
        render json: {
          status: :ok,
          data: Api::V1::ItemPresenter.new(current_user.items.find(params[:id])).present
        }
      end
    end
  end
end
