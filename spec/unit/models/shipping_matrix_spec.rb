describe Spree::ShippingMatrix do
  context 'when created' do
    subject { described_class.create(attrs) }

    context 'and name provided' do
      let(:attrs) { { name: 'UK next day' } }
      it { is_expected.to be_valid }
    end

    context 'and no name provided' do
      let(:attrs) { {} }
      it { is_expected.to be_invalid }
    end
  end

  it { is_expected.to respond_to(:rules) }
end
