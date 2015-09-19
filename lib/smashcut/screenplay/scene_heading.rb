module Smashcut
  class Screenplay
    # eg:
    # EXT. PARK - DAY
    class SceneHeading
      attr_reader :text

      def initialize(text)
        @text = text
      end
    end
  end
end
