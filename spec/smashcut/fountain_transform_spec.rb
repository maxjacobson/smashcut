module Smashcut
  RSpec.describe FountainTransform do
    let(:parser) { FountainParser.new }
    let(:transform) { described_class.new }
    let(:screenplay) { transform.apply(parser.parse(fountain_text)) }
    context "when the fountain text is some action" do
      let(:fountain_text) { "Max walks home." }

      it "makes a screenplay" do
        expect(screenplay).to eq(
          Screenplay.new([
            Screenplay::Action.new([
              Screenplay::PlainTextPhrase.new("Max walks home.")])]))
      end
    end

    context "When the fountain text is multiple actions" do
      let(:fountain_text) { "Max walks home.\n\nMax opens his door." }

      it "makes a screenplay with multiple actions" do
        expect(screenplay).to eq(
          Screenplay.new([
            Screenplay::Action.new([
              Screenplay::PlainTextPhrase.new("Max walks home.")]),
            Screenplay::Action.new([
              Screenplay::PlainTextPhrase.new("Max opens his door.")])]))
      end
    end

    context "when the fountain text has a scene heading" do
      let(:fountain_text) do
        "EXT. PARK - DAY\n\nA *large* extended family enjoys a picnic."
      end
      it "makes a screenplay with a scene heading" do
        expect(screenplay).to eq(
          Screenplay.new([
            Screenplay::SceneHeading.new("EXT. PARK - DAY"),
            Screenplay::Action.new([
              Screenplay::PlainTextPhrase.new("A "),
              Screenplay::EmphasizedPhrase.new("large", "*"),
              Screenplay::PlainTextPhrase.new(
                " extended family enjoys a picnic.")])]))
      end
    end
  end
end
