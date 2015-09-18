describe Smashcut::FountainParser.new.action do
  let(:action) { Smashcut::FountainParser.new.action }
  it "recognizes action" do
    action.should parse "He walked down the street."
  end
  it "annotates correctly" do
    action.parse("Gum stuck to his shoe")[:action].should eq "Gum stuck to his shoe"
  end
end
