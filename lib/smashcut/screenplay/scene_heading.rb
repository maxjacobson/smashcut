module Smashcut
  class Screenplay
    # eg:
    # EXT. PARK - DAY
    class SceneHeading
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def to_fountain
        text
      end

      def ==(other)
        to_fountain == other.to_fountain
      end
    end
  end
end
