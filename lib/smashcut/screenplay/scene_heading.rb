module Smashcut
  class Screenplay
    # eg:
    # EXT. PARK - DAY
    class SceneHeading
      include ScreenplayComponent

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def to_fountain
        text
      end

      def add_to(document)
        document.text(text)
      end
    end
  end
end
