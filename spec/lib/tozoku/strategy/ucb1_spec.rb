require 'spec_helper'
require 'tozoku/strategy/ucb1'

describe Tozoku::Strategy::Ucb1 do
  let(:arms) {
    [
      { 'name' => '1st', 'count' => 0, 'value' => 0 },
      { 'name' => '2nd', 'count' => 0, 'value' => 0 },
      { 'name' => '3rd', 'count' => 0, 'value' => 0 },
    ]
  }
  subject {
    described_class.new(arms)
  }

  describe '#initialize' do
    it { should be_an_instance_of described_class }
    it { expect(subject.arms).to be == arms       }
  end

  describe '#select_arm' do
    let(:chosen_arm) { subject.select_arm }
    let(:names)      { arms.map { |a| a['name'] } }

    it {
      expect(arms).to include chosen_arm
    }
  end

  describe 'update' do
    before { subject.update('1st', 1) }

    it { expect(arms[0]['value']).to be == 1 }
  end
end
