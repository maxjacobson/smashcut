# frozen_string_literal: true
module Smashcut
  class Screenplay
    # e.g.,
    # > THE END <
    class Centered
      include ScreenplayComponent

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def to_fountain
        "> #{text} <"
      end

      def add_to(document)
        document.text(text, :align => :center)
      end
    end
  end
end
