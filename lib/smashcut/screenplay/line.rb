module Smashcut
  class Screenplay
    # A specific line of dialogue. Helps make up a block of {Dialogue}.
    class Line
      include ScreenplayComponent

      attr_reader :phrases

      def initialize(phrases)
        @phrases = phrases
      end

      def to_fountain
        phrases.map(&:to_fountain).join
      end
    end
  end
end
