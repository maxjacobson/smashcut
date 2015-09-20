module Smashcut
  class Screenplay
    class PlainTextPhrase
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
