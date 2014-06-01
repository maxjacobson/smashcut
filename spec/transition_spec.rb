require_relative 'spec_helper'

describe Smashcut::FountainParser.new.transition do
  let(:transition) { Smashcut::FountainParser.new.transition }

  it 'can parse transitions' do
    transition.should parse "FADE TO:"
    transition.parse("FADE TO:")[:transition].should eq "FADE TO:"
  end
  it 'cannot parse non transitions' do
    transition.should_not parse "check out this next scene"
  end
end

