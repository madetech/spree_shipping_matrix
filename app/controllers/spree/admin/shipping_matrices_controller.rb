module Spree
  module Admin
    class ShippingMatricesController < ResourceController
      def new
        @shipping_matrix.rules.build
      end

      def edit
        @shipping_matrix.rules.build
      end
    end
  end
end
