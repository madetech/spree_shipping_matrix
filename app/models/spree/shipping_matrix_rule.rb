module Spree
  class ShippingMatrixRule < ActiveRecord::Base
    belongs_to :matrix, class_name: Spree::ShippingMatrix,
                        foreign_key: 'shipping_matrix_id'

    belongs_to :role, class_name: Spree::Role

    validates :matrix, presence: true
    validates :role, presence: true

    validates :min_line_item_total, presence: true,
                                    numericality: true

    validates :amount, presence: true,
                       numericality: true
  end
end
