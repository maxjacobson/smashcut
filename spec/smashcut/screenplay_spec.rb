# frozen_string_literal: true
module Smashcut
  RSpec.describe Screenplay do
    # TODO(#shipit): decide if this is main public interface
    describe "::from_fountain" do
      context "when it succeeds" do
        it "parses and transforms the fountain input" do
          screenplay = described_class.from_fountain("Hello world")
          expect(screenplay).to eq(
            described_class.new(
              [
                Screenplay::Action.new(
                  [
                    Screenplay::UnemphasizedPhrase.new("Hello world")
                  ]
                )
              ]
            )
          )
        end
      end

      context "when it fails to parse the input" do
        before do
          parser = instance_double(FountainParser)
          expect(FountainParser).to receive(:new).and_return(parser)
          exception = Parslet::ParseFailed.new("something went wrong...")
          expect(parser).to receive(:parse).and_raise(exception)
        end

        it do
          expect { described_class.from_fountain("Hello world") }
            .to raise_error("bad parse error")
        end
      end

      context "when it fails to transform the input" do
        before do
          transform = instance_double(FountainTransform)
          expect(FountainTransform).to receive(:new).and_return(transform)
          expect(transform).to receive(:apply).and_return(double)
        end

        it do
          expect { described_class.from_fountain("Hello world") }
            .to raise_error("bad transform error")
        end
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
          [
            Screenplay::Action.new(
              [
                Screenplay::UnemphasizedPhrase.new("Hello world!")
              ]
            )
          ]
        end

        let(:path) { pdf_path("action").to_s }

        it "creates a pdf" do
          pdf_generator = instance_double(PdfGenerator)
          expect(PdfGenerator).to receive(:new).with(screenplay)
            .and_return(pdf_generator)

          expect(pdf_generator).to receive(:save_as).with(path)
          screenplay.to_pdf(:path => path)
        end

        context "when you forget to provide a path" do
          it do
            expect { screenplay.to_pdf }.to raise_error(
              ArgumentError, /missing keyword/
            )
          end
        end
      end
    end
  end
end
