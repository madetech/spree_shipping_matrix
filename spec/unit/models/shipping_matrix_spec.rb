describe Spree::ShippingMatrix do
  let(:attrs) { { name: 'UK next day' } }
  subject { described_class.create(attrs) }

  context 'when created' do
    context 'and all required attributes provided' do
      it { is_expected.to be_valid }
    end

    context 'and no name provided' do
      let(:attrs) { {} }
      it { is_expected.to be_invalid }
    end
  end

  context '#rules scope sorting' do
    let(:matrix) { described_class.create(attrs) }

    subject { matrix.rules }

    let(:rule_with_lowest_min_line_item_total) do
      FactoryGirl.create(:shipping_matrix_rule, matrix: matrix,
                                                min_line_item_total: 50)
    end

    let(:rule_with_highest_min_line_item_total) do
      FactoryGirl.create(:shipping_matrix_rule, matrix: matrix,
                                                min_line_item_total: 100)
    end

    before(:each) do
      rule_with_lowest_min_line_item_total
      rule_with_highest_min_line_item_total
    end

    it { is_expected.to start_with(rule_with_highest_min_line_item_total) }
    it { is_expected.to end_with(rule_with_lowest_min_line_item_total) }
  end
end
