# frozen_string_literal: true
module Smashcut
  RSpec.describe Screenplay::Dialogue do
    let(:dialogue) { described_class.new(character, lines) }
    let(:character) { Screenplay::Character.new("AUGUST") }

    context "when there is one line" do
      let(:lines) do
        [Screenplay::Line.new(
          [Screenplay::UnemphasizedPhrase.new(
            "Hello, I wrote Big Fish.")])]
      end

      it do
        expect(dialogue.to_fountain).to eq "AUGUST\nHello, I wrote Big Fish."
      end
    end

    context "when there is one line, with a parenthetical" do
      let(:lines) do
        [
          Screenplay::LineWithParenthetical.new(
            "(coolly)",
            [Screenplay::UnemphasizedPhrase.new(
              "Hello, I wrote Charlie's Angels.")])
        ]
      end

      it do
        expected_text = "AUGUST\n(coolly)\nHello, I wrote Charlie's Angels."
        expect(dialogue.to_fountain).to eq expected_text
      end
    end

    context "when there are two lines, and the second has a parenthetical" do
      let(:lines) do
        [Screenplay::Line.new([Screenplay::UnemphasizedPhrase.new("Hello")]),
         Screenplay::LineWithParenthetical.new(
           "(politely)",
           [Screenplay::UnemphasizedPhrase.new("I wrote Big Fish.")])]
      end

      it do
        expected_text = "AUGUST\nHello\n(politely)\nI wrote Big Fish."
        expect(dialogue.to_fountain).to eq expected_text
      end
    end
  end
end
