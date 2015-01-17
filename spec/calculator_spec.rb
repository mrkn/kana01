require 'spec_helper'

describe Calculator do
  describe '#calculate' do
    context 'with 4*5+6&7|8' do
      it do
        excpect(Calculator.new.calculate "4*5+6&7|8").to eq 44
      end
    end
  end
end
