RSpec.describe Smashcut::FountainParser.new.action do
  let(:action) { Smashcut::FountainParser.new.action }
  it "recognizes action" do
    expect(action).to parse "He walked down the street."
  end
  it "annotates correctly" do
    action_text = action.parse("Gum stuck to his shoe")[:action]
    expect(action_text).to eq "Gum stuck to his shoe"
  end
end
