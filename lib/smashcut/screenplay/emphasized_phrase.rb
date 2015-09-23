module Smashcut
  class Screenplay
    # A bit of text that has some emphasis around it
    # Contrast it to {UnemphasizedPhrase}
    class EmphasizedPhrase
      include ScreenplayComponent

      attr_reader :text, :emphasis

      def initialize(text, emphasis)
        @text = text
        @emphasis = emphasis
      end

      def to_fountain
        "#{emphasis}#{text}#{emphasis.reverse}"
      end
    end
  end
end
