module Smashcut
  class Screenplay
    # This is a chunk of dialogue. Right now it doesn't do much besides wrap
    # a {Line}, but I think once we consider things like parentheticals it may
    # be helpful. Honestly, I'm not sure though.
    # TODO: look into it
    class Dialogue
      include ScreenplayComponent

      attr_reader :line

      def initialize(line)
        @line = line
      end

      def to_fountain
        line.to_fountain
      end
    end
  end
end
