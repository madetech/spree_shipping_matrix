module Spree
  class ShippingMatrix < ActiveRecord::Base
    has_many :rules, :class_name => Spree::ShippingMatrixRule

    validates :name, presence: true
  end
end
