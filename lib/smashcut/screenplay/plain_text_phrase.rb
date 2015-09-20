module Smashcut
  class Screenplay
    # TODO: describe me
    class PlainTextPhrase
      attr_reader :text

      def initialize(text)
        @text = text
      end

      # TODO: test me
      def to_fountain
        text
      end
    end
  end
end
