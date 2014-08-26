describe Spree::ShippingMatrix do
  context 'when created' do
    subject { described_class.create(attrs) }

    context 'and no name provided' do
      let(:attrs) { {} }
      it { is_expected.to be_invalid }
    end

    context 'and name provided' do
      let(:attrs) { { name: 'UK next day' } }
      it { is_expected.to be_valid }
    end
  end
end
