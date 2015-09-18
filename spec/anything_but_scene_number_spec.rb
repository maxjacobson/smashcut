RSpec.describe "anything_but_scene_number" do
  let(:rule) { Smashcut::FountainParser.new.anything_but_scene_number }

  it "can parse a simple string" do
    expect(rule).to parse "Hello"
  end

  it "can not parse a string with a scene number after it" do
    expect(rule).not_to parse "Hello #1#"
  end
end
