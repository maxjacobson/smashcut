module Smashcut
  RSpec.describe Screenplay do
    # TODO: this might be the public interface here, so this may be the place
    # to rescue parslet/prawn errors and reraise.. probs
    describe "::from_fountain" do
      it "parses and transforms the fountain input" do
        screenplay = Screenplay.from_fountain("Hello world")
        expect(screenplay).to eq(
          Screenplay.new([
            Screenplay::Action.new([
              Screenplay::UnemphasizedPhrase.new("Hello world")])]))
      end
    end

    let(:screenplay) { described_class.new(elements) }
    describe "#scene_count" do
      context "when there is one scene heading" do
        let(:elements) { [Screenplay::SceneHeading.new("INT. CAFE - DAY")] }
        it do
          expect(screenplay.scene_count).to eq 1
        end
      end

      context "when there are two scene headings" do
        let(:elements) do
          [Screenplay::SceneHeading.new("INT. CAFE - DAY"),
           Screenplay::SceneHeading.new("INT. APARTMENT - NIGHT")]
        end
        it do
          expect(screenplay.scene_count).to eq 2
        end
      end
    end

    describe "#to_pdf" do
      context "when the PDF is just some action" do
        let(:elements) do
          [Screenplay::Action.new([
            Screenplay::UnemphasizedPhrase.new("Hello world!")])]
        end

        let(:path) { pdf_path("action").to_s }

        it "creates a pdf" do
          pdf_generator = instance_double(PdfGenerator)
          expect(PdfGenerator).to receive(:new).with(screenplay)
            .and_return(pdf_generator)

          expect(pdf_generator).to receive(:save_as).with(path)
          screenplay.to_pdf(:path => path)
        end
      end
    end
  end
end
