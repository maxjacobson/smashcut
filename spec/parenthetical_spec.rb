RSpec.describe Smashcut::FountainParser.new.parenthetical do
  let(:parenthetical) do
    Smashcut::FountainParser.new.parenthetical
  end

  describe "happy path" do
    let(:text) { "(quiet)" }

    it "should parse parentheticals" do
      expect(parenthetical).to parse text
    end

    it "should annotate parentheticals" do
      expect(parenthetical.parse(text)[:parenthetical]).to eq text
    end
  end

  describe "sad path" do
    it "should not parse non parentheticals" do
      expect(parenthetical).not_to parse "Hello"
    end
  end
end
