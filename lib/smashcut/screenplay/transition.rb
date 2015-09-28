module Smashcut
  class Screenplay
    # TODO: add some specs
    # e.g.,
    # FADE TO:
    class Transition
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
