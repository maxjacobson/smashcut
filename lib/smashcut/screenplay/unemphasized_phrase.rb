# frozen_string_literal: true
module Smashcut
  class Screenplay
    # Represents a bit of text which has no emphasis
    # Contrast it to {EmphasizedPhrase}
    class UnemphasizedPhrase
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
