# frozen_string_literal: true
module Smashcut
  class Screenplay
    # A class which includes this is going to be a simple value object which
    # implements a to_fountain method, and represents some part of a screenplay
    module ScreenplayComponent
      def ==(other)
        to_fountain == other.to_fountain
      end

      def hash
        to_fountain.hash
      end

      def eql?(other)
        to_fountain == other.to_fountain
      end
    end
  end
end
