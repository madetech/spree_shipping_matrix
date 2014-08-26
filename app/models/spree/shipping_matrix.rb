module Spree
  class ShippingMatrix < ActiveRecord::Base
    validates :name, presence: true
  end
end
