RSpec.describe Smashcut::FountainParser.new.dialogue do
  let(:dialogue) { Smashcut::FountainParser.new.dialogue }

  context "with parentheticals" do
    describe "simple parentheticals" do
      let(:text) do
        read_fountain("simple dialogue with parenthetical").chomp
      end

      it "can parse dialogue with parentheticals" do
        expect(dialogue).to parse text
      end

      it "can annotate dialogue with parentheticals" do
        token = dialogue.parse(text)[:dialogue]
        expect(token[:character_name]).to eq "BUD"
        expect(token[:parenthetical]).to eq "(stoned)"
        expect(token[:speech]).to eq "Whoa, show me that again..."
      end
    end
  end

  context "without parentheticals" do
    describe "simple dialogue" do
      let(:text) { "MAX\nWhat time is your train?" }

      it "can parse simple dialogue" do
        expect(dialogue).to parse text
      end

      it "can annotate simple dialogue" do
        token = dialogue.parse(text)[:dialogue]
        expect(token[:character_name]).to eq "MAX"
        expect(token[:speech]).to eq "What time is your train?"
      end
    end
  end
end
