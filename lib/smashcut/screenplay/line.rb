module Smashcut
  class Screenplay
    # This is a line of dialogue. it knows who said it, and what was said
    class Line
      include ScreenplayComponent

      attr_reader :name, :speech

      def initialize(name, speech)
        @name = name
        @speech = speech
      end

      # TODO: test me
      def to_fountain
        "#{name}\n#{speech}"
      end
    end
  end
end
