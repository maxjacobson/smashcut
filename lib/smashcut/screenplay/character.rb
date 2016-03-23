# frozen_string_literal: true
module Smashcut
  class Screenplay
    # The name of a character who says some dialogue.
    class Character
      include ScreenplayComponent

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def to_fountain
        name
      end
    end
  end
end
