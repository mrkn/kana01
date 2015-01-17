require 'spec_helper'

describe Calculator::Parser do
  let(:parser) do
    described_class.new(source)
  end

  describe '#tokens' do
    context 'for "4*5+6&7|8"' do
      let(:source) do
        "4*5+6&7|8"
      end

      it do
        expect(parser.tokens).to eq(
          [4, '*', 5, '+', 6, '&', 7, '|', 8]
        )
      end
    end
  end

  describe '#expression' do
    context 'for "1+2*3"' do
      let(:source) do
        "4*5+6&7|8"
      end

      it do
        expect(parser.expression).to eq([:*, 4, [:+, 5, [:&, 6, [:|, 7, 8]]]])
      end
    end

    context 'for "42"' do
      let(:source) do
        "42"
      end

      it do
        expect(parser.expression).to eq(42)
      end
    end

    context 'for "1+2"' do
      let(:source) do
        "1+2"
      end

      it do
        expect(parser.expression).to eq([:+, 1, 2])
      end
    end

    context 'for "1+2*3"' do
      let(:source) do
        "1+2*3"
      end

      it do
        expect(parser.expression).to eq([:*, [:+, 1, 2], 3])
      end
    end
  end

  describe '#number' do
    context 'for "42"' do
      let(:source) do
        "42"
      end

      it do
        expect(parser.number).to eq(42)
      end
    end

    context 'for "+"' do
      let(:source) do
        "+"
      end

      it do
        expect { parser.number }.to raise_error(described_class::ParseError)
      end
    end
  end
end
