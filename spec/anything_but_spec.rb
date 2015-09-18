RSpec.describe "anything_but" do
  let(:parser) { Smashcut::FountainParser.new }

  it "should not parse input with excluded characters" do
    rule = parser.anything_but("a")
    expect(rule).not_to parse "veronica"
  end

  it "should parse input without exlcuded characters" do
    rule = parser.anything_but("q")
    expect(rule).to parse "veronica"
  end
end
