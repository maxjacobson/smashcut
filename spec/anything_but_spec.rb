describe "anything_but" do
  let(:parser) { Smashcut::FountainParser.new }

  it "should not parse input with excluded characters" do
    rule = parser.anything_but("a")
    rule.should_not parse "veronica"
  end

  it "should parse input without exlcuded characters" do
    rule = parser.anything_but("q")
    rule.should parse "veronica"
  end
end
