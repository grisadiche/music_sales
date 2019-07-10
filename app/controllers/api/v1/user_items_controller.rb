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

#should this actually go to the items_controller? would I inherit it above?
      def new
      end

      def create
        JSON.parse(response.body)['data']
      end

      def update
      end

      private

      def safe_params
        params.require(:item).permit(:manufacturer, :model, :price, :image)
      end
    end
  end
end
