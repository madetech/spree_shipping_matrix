FactoryGirl.define do
  factory :shipping_matrix, class: Spree::ShippingMatrix do
    name 'A shipping matrix'

    factory :shipping_matrix_with_rules do
      ignore do
        num_of_rules 1
      end

      after(:create) do |matrix, evaluator|
        evaluator.num_of_rules.times do
          FactoryGirl.create(:shipping_matrix_rule, matrix: matrix)
        end
      end
    end
  end
end
