describe "anything_but_scene_number" do
  let(:rule) { Smashcut::FountainParser.new.anything_but_scene_number }

  it "can parse a simple string" do
    rule.should parse "Hello"
  end

  it "can not parse a string with a scene number after it" do
    rule.should_not parse "Hello #1#"
  end
end
