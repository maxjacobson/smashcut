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

      def italicized?
        [1, 3].include?(star_count)
      end

      def underlined?
        emphasis.include?("_")
      end

      def bolded?
        [2, 3].include?(star_count)
      end

      private

      def star_count
        emphasis.chars.count("*")
      end
    end
  end
end
