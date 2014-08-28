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

    def matches?(info)
      matches_role?(info) && matches_line_item_total?(info)
    end

    private

    def matches_role?(info)
      if info[:user].nil?
        role.name == 'entry'
      else
        matches_user_role?(info)
      end
    end

    def matches_user_role?(info)
      info[:user].spree_roles.include?(role)
    end

    def matches_line_item_total?(info)
      info[:line_item_total] > min_line_item_total
    end
  end
end
