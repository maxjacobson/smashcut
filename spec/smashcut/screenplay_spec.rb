module Smashcut
  RSpec.describe Screenplay do
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
      after(:each) { clean_up_pdfs }

      context "when the PDF is just some action" do
        let(:elements) do
          [
            Screenplay::Action.new([
              Screenplay::UnemphasizedPhrase.new("Hello world!")])]
        end

        it "creates a pdf" do
          expect(pdf_path).to_not have_pdf("action")
          screenplay.make_pdf(pdf_path("action").to_s)
          expect(pdf_path).to have_pdf("action")
        end
      end
    end
  end
end
