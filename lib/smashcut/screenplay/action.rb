module Smashcut
  class Screenplay
    # This is a screenplay element. Perhaps the most common one.
    class Action
      attr_reader :elements

      def initialize(phrases)
        @elements = phrases
      end


      def to_fountain
        elements.map(&:to_fountain).join
      end

      def ==(other)
        to_fountain == other.to_fountain
      end
    end
  end
end
