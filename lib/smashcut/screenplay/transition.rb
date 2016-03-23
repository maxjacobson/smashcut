# frozen_string_literal: true
module Smashcut
  class Screenplay
    # TODO(#shipit): add some specs
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

      def add_to(document)
        document.text(to_fountain)
      end
    end
  end
end
