module Smashcut
  RSpec.describe Screenplay::EmphasizedPhrase do
    let(:text) { "lol" }
    let(:phrase) { described_class.new(text, emphasis) }

    describe "#to_fountain" do
      context "when the emphasis is *" do
        let(:emphasis) { "*" }
        it do
          expect(phrase.to_fountain).to eq "*lol*"
        end
      end

      context "when the emphasis is *_**" do
        let(:emphasis) { "*_**" }
        it do
          expect(phrase.to_fountain).to eq "*_**lol**_*"
        end
      end
    end
  end
end
