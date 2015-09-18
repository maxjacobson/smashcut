describe Smashcut::FountainParser.new.scene_number do
  let(:scene_number) { Smashcut::FountainParser.new.scene_number }

  describe "the syntax" do
    it "can parse normal ones" do
      scene_number.should parse " #1#"
    end
    it "can parse without a space" do
      scene_number.should parse "#1#"
    end
    it "can parse repeating numbers" do
      scene_number.should parse "#1111#"
    end
    it "can parse non-digit characters" do
      scene_number.should parse "#two#"
    end
    it "can parse a few other characters" do
      scene_number.should parse "#1.#"
      scene_number.should parse "#1-1#"
    end
  end

  describe "annotation" do
    it "can capture digits" do
      scene_number.parse("#1#")[:scene_number].should eq "1"
    end
    it "can capture repeating digits" do
      scene_number.parse("#111#")[:scene_number].should eq "111"
    end
  end
end
