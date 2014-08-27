module Spree
  class ShippingMatrixCalculator < Spree::ShippingCalculator
    preference :matrix_id, :matrix_id

    def self.description
      'Shipping Matrix Calculator'
    end

    def compute_package(package)
      0
    end
  end
end
