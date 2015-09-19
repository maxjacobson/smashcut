module Smashcut
  class Screenplay
    # TODO: add specs for this class
    # This is a screenplay element. Perhaps the most common one.
    class Action
      attr_reader :text

      def initialize(text)
        @text = text
      end
    end
  end
end
