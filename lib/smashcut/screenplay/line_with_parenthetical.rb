# frozen_string_literal: true
module Smashcut
  class Screenplay
    # A different kind of {Line}, which is preceded by a parenthetical, which
    # modifies the tone of the {Line}
    class LineWithParenthetical
      include ScreenplayComponent

      attr_reader :parenthetical, :phrases

      def initialize(parenthetical, phrases)
        @parenthetical = parenthetical
        @phrases = phrases
      end

      def to_fountain
        ([parenthetical] + phrases.map(&:to_fountain)).join("\n")
      end
    end
  end
end
