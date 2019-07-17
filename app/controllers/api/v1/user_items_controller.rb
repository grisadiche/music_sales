module Api
  module V1
    class UserItemsController < AuthenticatedController
      # protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

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

      def new
      end

      def create
        @new_item = Item.new
        @new_item = current_user.items.build(safe_params)
          if @new_item.save
            render json: {
              status: :created,
            }
          else
            render json: {
              error: "not_found"
            }, status: :not_found
        end
      end

      def update
      end

      private

      def safe_params
        params.require(:user_item).permit(:manufacturer, :model, :weight, :price, :description, :serial_number, :color, :image) #add :image with base64 encoding
      end
    end
  end
end
