RSpec.describe Smashcut::FountainTransform do
  let(:parser) { Smashcut::FountainParser.new }
  let(:tree) { parser.parse(fountain_text) }

  let(:transform) { Smashcut::FountainTransform.new }
  let(:screenplay) { transform.apply(tree) }

  context "when the fountain text is some action" do
    let(:fountain_text) { "Max walks home." }

    it "makes a screenplay" do
      expect(screenplay).to be_a Smashcut::Screenplay
      expect(screenplay.elements.length).to eq 1
      action = screenplay.elements.first
      expect(action).to be_a Smashcut::Screenplay::Action
      expect(action.text).to eq "Max walks home."
    end
  end

  context "When the fountain text is multiple actions" do
    let(:fountain_text) { "Max walks home.\n\nMax opens his door." }

    it "makes a screenplay with multiple actions" do
      expect(screenplay).to be_a Smashcut::Screenplay
      expect(screenplay.elements.length).to eq 2
      expect(screenplay.elements.first).to be_a Smashcut::Screenplay::Action
      expect(screenplay.elements.first.text).to eq "Max walks home."
      expect(screenplay.elements.last).to be_a Smashcut::Screenplay::Action
      expect(screenplay.elements.last.text).to eq "Max opens his door."
    end
  end
end
