module Api
  module V1
    class ItemsPresenter
      attr_reader :items

      def initialize(items)
        @items = items
      end

      def present
        items.map do |item|
          ItemPresenter.new(item).present
        end
      end
    end
  end
end
