# frozen_string_literal: true
module Smashcut
  RSpec.describe Screenplay::UnemphasizedPhrase do
    let(:text) { "lol man..." }
    let(:phrase) { described_class.new(text) }
    describe "#to_fountain" do
      it "spits back out the text" do
        expect(phrase.to_fountain).to eq text
      end
    end
  end
end
