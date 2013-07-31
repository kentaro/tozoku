require 'spec_helper'

describe Tozoku do
  let(:strategy) { :EpsilonGreedy }
  let(:arms) {
    [
      { 'name' => '1st', 'count' => 0, 'value' => 0 },
      { 'name' => '2nd', 'count' => 0, 'value' => 0 },
      { 'name' => '3rd', 'count' => 0, 'value' => 0 },
    ]
  }
  subject {
    described_class.new(strategy, arms)
  }

  describe '#initialize' do
    it { should be_an_instance_of described_class }
    it { expect(subject.strategy).to be_an_instance_of Tozoku::Strategy::EpsilonGreedy }
  end
end
