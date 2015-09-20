module Smashcut
  class Screenplay
    # TODO: describe me
    class EmphasizedPhrase
      attr_reader :text, :emphasis

      def initialize(text, emphasis)
        @text = text
        @emphasis = emphasis
      end

      # TODO: test me
      def to_fountain
        "#{emphasis}#{text}#{emphasis.reverse}"
      end
    end
  end
end
