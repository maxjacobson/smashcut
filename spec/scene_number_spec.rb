RSpec.describe Smashcut::FountainParser.new.scene_number do
  let(:scene_number) { Smashcut::FountainParser.new.scene_number }

  describe "the syntax" do
    it "can parse normal ones" do
      expect(scene_number).to parse " #1#"
    end
    it "can parse without a space" do
      expect(scene_number).to parse "#1#"
    end
    it "can parse repeating numbers" do
      expect(scene_number).to parse "#1111#"
    end
    it "can parse non-digit characters" do
      expect(scene_number).to parse "#two#"
    end
    it "can parse a few other characters" do
      expect(scene_number).to parse "#1.#"
      expect(scene_number).to parse "#1-1#"
    end
  end

  describe "annotation" do
    it "can capture digits" do
      expect(scene_number.parse("#1#")[:scene_number]).to eq "1"
    end
    it "can capture repeating digits" do
      expect(scene_number.parse("#111#")[:scene_number]).to eq "111"
    end
  end
end
