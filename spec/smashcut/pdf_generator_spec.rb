module Smashcut
  RSpec.describe PdfGenerator do
    let(:pdf_generator) { described_class.new(screenplay) }
    let(:screenplay) { Screenplay.from_fountain(fountain_text) }

    context "when the screenplay is no good" do
      let(:screenplay) { double }
      it do
        expect { pdf_generator }.to raise_error(ArgumentError)
      end
    end

    context "when the fountain is simple" do
      # running before, not after, so I can look at what the tests are making
      # if I want to. it'll run before *each spec* (in this group) so I just get
      # to look at the last one, but still, I can work with that
      before { clean_up_pdfs }
      let(:fountain_text) do
        read_fountain "dialogue with multiple parentheticals"
      end

      let(:path) { pdf_path("tarrytown") }

      it "produces a pdf" do
        expect(pdf_path).to_not have_pdf("tarrytown")
        pdf_generator.save_as(path)
        expect(pdf_path).to have_pdf("tarrytown")
      end
    end

    context "when the fountain has centered text" do
      before { clean_up_pdfs }
      let(:fountain_text) do
        read_fountain "two scenes with a transition"
      end

      let(:path) { pdf_path("intent") }

      it "produces a pdf" do
        expect(pdf_path).to_not have_pdf("intent")
        pdf_generator.save_as(path)
        expect(pdf_path).to have_pdf("intent")
      end
    end
  end
end
