describe Spree::ShippingMatrixCalculator do
  let(:variant1) { build(:variant, price: 10) }
  let(:variant2) { build(:variant, price: 20) }

  let(:role) { create(:role) }
  let(:user) { create(:user, spree_roles: [role]) }

  let (:package) { build(:stock_package, variants_contents: { variant1 => 4, variant2 => 6 }) }

  before(:each) do
    package.contents.first.inventory_unit.order.update(user: user)
  end

  context '#compute' do
    subject { described_class.new(preferred_matrix_id: matrix.id).compute(package).to_f }

    context 'when matrix has no rules' do
      let(:matrix) { create(:shipping_matrix) }
      it { is_expected.to eq(0.0) }
    end

    context 'when matrix has rules' do
      let(:matrix) { create(:shipping_matrix_with_rules, num_of_rules: 5) }

      let(:highest_min_line_item_total) do
        create(:shipping_matrix_rule, min_line_item_total: 100, role: role)
      end

      let(:rule_with_matching_role) { highest_min_line_item_total }

      before(:each) do
        matrix.rules << highest_min_line_item_total
      end

      context 'and a rule with highest matching min line item total has amount of 4.99' do
        before(:each) { highest_min_line_item_total.update!(amount: 4.99) }
        it { is_expected.to eq(highest_min_line_item_total.amount.to_f) }
      end

      context 'and two rules with the same highest min line item total match' do
        let(:another_rule) { create(:shipping_matrix_rule, min_line_item_total: 100) }

        before(:each) do
          matrix.rules << another_rule
        end

        context 'but only one rule#role matches and has amount of 3.99' do
          before(:each) do
            rule_with_matching_role.update!(amount: 3.99)
            another_rule.update!(amount: 4.99)
          end

          it { is_expected.to eq(rule_with_matching_role.amount.to_f) }
        end

        context 'and both roles match' do
          let(:matching_roles) { [rule_with_matching_role, another_rule] }

          before(:each) do
            rule_with_matching_role.update!(amount: 4.99)
            another_rule.update!(role: role, amount: 3.99)
          end

          it 'should equal #amount from first matching role' do
            is_expected.to eq(matching_roles.first.amount.to_f)
          end
        end
      end

      context 'and order anonymous' do
        before(:each) do
          package.contents.first.inventory_unit.order.update(user: nil, email: 'e@e.com')
        end

        let(:first_entry_rule) do
          create(:shipping_matrix_rule, matrix: matrix, role: create(:role, name: 'entry'))
        end

        it { is_expected.to eq(first_entry_rule.amount.to_f) }
      end
    end
  end
end
