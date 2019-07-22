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

      def create
        @new_item = current_user.items.build(safe_params.except(:image))
        convert_and_attach_image!
        if @new_item.save
          render json: {
            data: Api::V1::ItemPresenter.new(@new_item).present
          }, status: :created
        else
          render json: {
            error: @new_item.errors.full_messages.join(', ')
          }, status: :unprocessable_entity
        end
      end

      def update
      end

      private

      def convert_and_attach_image!
        # delete the image from the params
        blob = safe_params.delete(:image)
        return unless blob.present?
        @new_item.image.attach(
          io: StringIO.new(Base64.decode64(blob)),
          filename: 'my_image.jpg',
          content_type: 'image/png'
        )
      end

      def safe_params
        @_safe_params ||=
          params.require(:user_item).permit(:manufacturer,
                                            :model,
                                            :weight,
                                            :price,
                                            :description,
                                            :serial_number,
                                            :color,
                                            :image)
      end
    end
  end
end
