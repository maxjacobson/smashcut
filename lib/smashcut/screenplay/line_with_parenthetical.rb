module Smashcut
  class Screenplay
    # A different kind of {Line}, which is preceded by a parenthetical, which
    # modifies the tone of the {Line}
    class LineWithParenthetical
      include ScreenplayComponent

      attr_reader :parenthetical, :text

      def initialize(parenthetical, text)
        @parenthetical = parenthetical
        @text = text
      end

      def to_fountain
        [parenthetical, text].join("\n")
      end
    end
  end
end
