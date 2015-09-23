require "prawn"
require "smashcut/screenplay"

module Smashcut
  class Screenplay
    class PdfGenerator
      def initialize(screenplay)
        @screenplay = screenplay
      end

      def write(path)
        Prawn::Document.generate(path) do
          text screenplay.to_fountain
        end
      end

      private

      attr_reader :screenplay
    end
  end
end
