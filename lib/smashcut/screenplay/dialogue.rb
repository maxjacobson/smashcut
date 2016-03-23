# frozen_string_literal: true
module Smashcut
  class Screenplay
    # This is a block of dialogue. it knows who said it, and what was said
    class Dialogue
      include ScreenplayComponent

      attr_reader :character, :lines

      def initialize(character, lines)
        @character = character
        @lines = lines
      end

      def to_fountain
        ([character] + lines).map(&:to_fountain).join("\n")
      end

      def add_to(document)
        document.text(to_fountain, :align => :center)
      end
    end
  end
end
