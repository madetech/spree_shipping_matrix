module Spree
  class ShippingMatrixCalculator < Spree::ShippingCalculator
    preference :matrix_id, :matrix_id

    def self.description
      'Shipping Matrix Calculator'
    end

    def compute_package(package)
      matched_amount(user: package.contents.first.inventory_unit.order.user,
                     line_item_total: total(package.contents))
    end

    private

    def matched_amount(info)
      matched = matched_rule(info)

      if matched.nil?
        0
      else
        matched.amount
      end
    end

    def matched_rule(info)
      matched = matrix.rules.find { |rule| rule.matches?(info) }

      if matched.nil?
        matrix.rules.last
      else
        matched
      end
    end

    def matrix
      @matrix ||= Spree::ShippingMatrix.find(preferred_matrix_id)
    end
  end
end
