module Api
  module V1
    class ItemsController < Api::V1::BaseController
      def index
        render json: {
          status: :ok,
          data: Api::V1::ItemsPresenter.new(Item.all).present
        }
      end

      def show
        render json: {
          status: :ok,
          data: Api::V1::ItemPresenter.new(Item.find(params[:id])).present
        }
      end
    end
  end
end
