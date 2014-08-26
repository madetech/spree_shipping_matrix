module Spree
  class ShippingMatrix < ActiveRecord::Base
    has_many :rules, ->{ order('min_line_item_total DESC') },
                     class_name: Spree::ShippingMatrixRule

    validates :name, presence: true
  end
end
