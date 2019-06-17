module Api
  module V1
    class ItemsController < ApplicationController
      class Item < ::Item
        # Note: this does not take into consideration the create/update actions for changing released_on
        def as_json(options = {})
          super.merge(released_on: released_at.to_date)
        end
      end

      respond_to :json

      def index
        respond_with Item.all
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
