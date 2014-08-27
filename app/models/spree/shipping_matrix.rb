module Spree
  class ShippingMatrix < ActiveRecord::Base
    has_many :rules, ->{ order('min_line_item_total DESC') },
                     class_name: Spree::ShippingMatrixRule,
                     inverse_of: :matrix

    accepts_nested_attributes_for :rules, allow_destroy: true,
                                          reject_if: :rule_blank?

    validates :name, presence: true

    private

    def rule_blank?(attributes)
      attributes['min_line_item_total'].blank? || attributes['amount'].blank?
    end
  end
end
