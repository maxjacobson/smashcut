module Smashcut
  class Screenplay
    class ItalicizedPhrase
      attr_reader :text

      def initialize(text)
        @text = text
      end
    end
  end
end
