RSpec.describe Smashcut::FountainParser.new.character_name do
  let(:character_name) { Smashcut::FountainParser.new.character_name }

  context "with leading @" do
    it "can parse names with leading @" do
      expect(character_name).to parse "@MAX"
    end
    it "can parse names with leading @ with lower case letters" do
      expect(character_name).to parse "@Max Jacobson"
    end
    it "annotates the name without the @" do
      token = character_name.parse "@Max Jacobson"
      expect(token[:character_name]).to eq "Max Jacobson"
    end
  end

  context "without leading @" do
    it "can parse names in all capitals" do
      expect(character_name).to parse "MAX"
    end

    it "can parse names in all capitals with spaces" do
      expect(character_name).to parse "MAX JACOBSON"
    end

    it "can not parse names with lower case characters" do
      expect(character_name).not_to parse "Max Jacobson"
    end

    it "can parse names with numbers" do
      expect(character_name).to parse "COP 2"
    end
  end
end
