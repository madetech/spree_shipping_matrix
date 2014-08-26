FactoryGirl.define do
  factory :shipping_matrix_rule, class: Spree::ShippingMatrixRule do
    association :matrix, factory: :shipping_matrix
    association :role
    min_line_item_total 25
    amount 2.99
  end
end
