describe Spree::ShippingMatrixRule do
  context 'when created' do
    subject { described_class.create(attrs) }

    let(:attrs) { { role: create(:role),
                    min_line_item_total: 50,
                    amount: 2.99,
                    matrix: create(:shipping_matrix) } }

    context 'and all required parameters are provided' do
      it { is_expected.to be_valid }
    end

    [:matrix, :role, :min_line_item_total, :amount].each do |field|
      context "and a ##{field} is not provided" do
        before(:each) { attrs.delete(field) }
        it { is_expected.to be_invalid }
      end
    end

    [:matrix, :role, :min_line_item_total, :amount].each do |field|
      context "and a ##{field} is not provided" do
        before(:each) { attrs.delete(field) }
        it { is_expected.to be_invalid }
      end
    end

    [:min_line_item_total, :amount].each do |field|
      context "and text value provided for ##{field}" do
        before(:each) { attrs.merge!(field => 'word') }
        it { is_expected.to be_invalid }
      end
    end
  end
end
