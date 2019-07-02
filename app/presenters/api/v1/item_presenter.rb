module Api
  module V1
    class ItemPresenter
      attr_reader :item

      def initialize(item)
        @item = item
      end

      def present
        {
          manufacturer: item.manufacturer,
          model: item.model,
          price: item.price,
          id: item.id
        }
      end
    end
  end
end
