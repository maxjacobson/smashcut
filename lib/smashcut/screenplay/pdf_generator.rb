require "prawn"
require "smashcut/screenplay"

module Smashcut
  class Screenplay
    class PdfGenerator
      def initialize(screenplay)
        @screenplay = screenplay
      end

      # TODO: be much cleverer
      def write(path)
        txt = screenplay.to_fountain
        Prawn::Document.generate(path) do
          text txt
        end
      end

      private

      attr_reader :screenplay
    end
  end
end
