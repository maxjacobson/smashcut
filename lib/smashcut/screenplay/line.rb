module Smashcut
  class Screenplay
    # A specific line of dialogue. Helps make up a block of {Dialogue}.
    class Line
      include ScreenplayComponent

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def to_fountain
        text
      end
    end
  end
end
