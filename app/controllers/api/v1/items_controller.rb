module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: {
          status: :ok,
          data: Api::V1::ItemsPresenter.new(Item.all).present
        }
      end

      def show
        respond_with Item.find(item[:id])
      end

      def create
        respond_with Item.create(params[:item])
      end

      def update
        respond_with Item.update(item[:id], item[:product])
      end

      def destroy
        respond_with Item.destroy(item[:id])
      end
    end
  end
end
