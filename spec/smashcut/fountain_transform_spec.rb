# frozen_string_literal: true
module Smashcut
  RSpec.describe FountainTransform do
    let(:parser) { FountainParser.new }
    let(:transform) { described_class.new }
    let(:screenplay) { transform.apply(parser.parse(fountain_text)) }

    # it can parse all of the samples
    Dir.glob("./spec/support/screenplays/*.fountain").each do |file|
      context "when the text is #{file}" do
        let(:fountain_text) { File.read(file) }
        it do
          expect(screenplay).to be_a Screenplay
        end
      end
    end

    context "when the fountain text is some action" do
      let(:fountain_text) { "Max walks home." }

      it "makes a screenplay" do
        expect(screenplay).to eq(
          Screenplay.new(
            [
              Screenplay::Action.new(
                [
                  Screenplay::UnemphasizedPhrase.new("Max walks home.")
                ]
              )
            ]
          )
        )
      end
    end

    context "When the fountain text is multiple actions" do
      let(:fountain_text) { "Max walks home.\n\nMax opens his door." }

      it "makes a screenplay with multiple actions" do
        expect(screenplay).to eq(
          Screenplay.new(
            [
              Screenplay::Action.new(
                [
                  Screenplay::UnemphasizedPhrase.new("Max walks home.")
                ]
              ),
              Screenplay::Action.new(
                [
                  Screenplay::UnemphasizedPhrase.new("Max opens his door.")
                ]
              )
            ]
          )
        )
      end
    end

    context "when the fountain text has a scene heading" do
      let(:fountain_text) do
        "EXT. PARK - DAY\n\nA *large* extended family enjoys a picnic."
      end
      it "makes a screenplay with a scene heading" do
        expect(screenplay).to eq(
          Screenplay.new(
            [
              Screenplay::SceneHeading.new("EXT. PARK - DAY"),
              Screenplay::Action.new(
                [
                  Screenplay::UnemphasizedPhrase.new("A "),
                  Screenplay::EmphasizedPhrase.new("large", "*"),
                  Screenplay::UnemphasizedPhrase.new(
                    " extended family enjoys a picnic."
                  )
                ]
              )
            ]
          )
        )
      end
    end

    context "when the fountain text has some dialogue" do
      let(:fountain_text) { read_fountain "scene heading action and dialogue" }

      it "makes a screenplay" do
        expect(screenplay).to eq(
          Screenplay.new(
            [
              Screenplay::SceneHeading.new("EXT. CARNIVAL - NIGHT"),
              Screenplay::Action.new(
                [
                  Screenplay::UnemphasizedPhrase.new(
                    "MAX walks between the games."
                  )
                ]
              ),
              Screenplay::Dialogue.new(
                Screenplay::Character.new("MAX"),
                [
                  Screenplay::Line.new(
                    [
                      Screenplay::UnemphasizedPhrase.new("Whoa")
                    ]
                  )
                ]
              )
            ]
          )
        )
      end
    end

    context "when the fountain text has some parenthetical dialogue" do
      let(:fountain_text) { read_fountain "simple dialogue with parenthetical" }
      it do
        expect(screenplay).to eq Screenplay.new(
          [
            Screenplay::Dialogue.new(
              Screenplay::Character.new("BUD"),
              [
                Screenplay::LineWithParenthetical.new(
                  "(stoned)",
                  [
                    Screenplay::UnemphasizedPhrase.new(
                      "Whoa, show me that again..."
                    )
                  ]
                )
              ]
            )
          ]
        )
      end
    end

    context "when the fountain text contains a transition" do
      let(:fountain_text) { read_fountain "two scenes with a transition" }
      it do
        expect(screenplay).to eq Screenplay.new(
          [
            Screenplay::SceneHeading.new("EXT. PARK - NIGHT"),
            Screenplay::Action.new(
              [
                Screenplay::UnemphasizedPhrase.new(
                  "Max bicycles around the park. What is he running from?"
                )
              ]
            ),
            Screenplay::Transition.new("FADE TO:"),
            Screenplay::SceneHeading.new("INT. A CARDBOARD BOX - NIGHT"),
            Screenplay::Action.new(
              [
                Screenplay::UnemphasizedPhrase.new(
                  "Max shrinks down real small."
                )
              ]
            ),
            Screenplay::Centered.new("LOL THE END")
          ]
        )
      end
    end
  end
end
