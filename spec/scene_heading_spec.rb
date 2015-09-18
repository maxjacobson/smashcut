describe Smashcut::FountainParser.new.scene_heading do
  let(:scene_heading) { Smashcut::FountainParser.new.scene_heading }

  describe "leading dot scene headings" do
    let(:text) { ".IN THE WOODS AT NIGHT" }

    it "parses leading dot scene headings" do
      scene_heading.should parse text
    end
    it "annotates and discards the dot" do
      token = scene_heading.parse text
      token[:scene_heading].should eq "IN THE WOODS AT NIGHT"
    end
  end

  describe "acceptable scene heading openers" do
    after(:each) do
      scene_heading.should parse @scene_heading
      token = scene_heading.parse(@scene_heading)
      token[:scene_heading].should eq @scene_heading
    end
    it "can parse INT." do
      @scene_heading = "INT. APARTMENT - NIGHT"
    end
    it "can parse int." do
      @scene_heading = "int. apartment - day"
    end
    it "can parse EXT." do
      @scene_heading = "EXT. PARK - NIGHT"
    end
    it "can parse ext." do
      @scene_heading = "ext. space - forever"
    end
    it "can parse INT without a dot" do
      @scene_heading = "INT MALL - NIGHT"
    end
    it "can parse I/E." do
      @scene_heading = "I/E. CONVERTIBLE - DAY"
    end
    it "can parse int/ext" do
      @scene_heading = "int/ext convertible - day"
    end
    it "can parse int./ext" do
      @scene_heading = "INT./EXT. TRUCK - DAY"
    end
  end

  describe "scene headings with scene numbers" do
    let(:text) { 'EXT. HIKING TRAIL - DAY#1#' }
    it "can parse these" do
      scene_heading.should parse text
    end
    it "knows which part is which" do
      token = scene_heading.parse(text)
      token[:scene_heading].should eq "EXT. HIKING TRAIL - DAY"
      token[:scene_number].should eq "1"
    end

    it 'can parse scene numbers which aren\'t digits' do
      scene_heading.should parse "INT. HIKING DOME - DAY #TWO#"
    end
  end

  describe "edge cases" do
    it "only looks at leading dots, not trailing dots" do
      scene_heading.should_not parse "The end."
    end
    it "should allow for characters named Esteban" do
      scene_heading.should_not parse "Esteban walked down the sidewalk"
    end
  end
end
