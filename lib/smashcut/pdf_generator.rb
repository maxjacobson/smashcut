require "prawn"
require "smashcut/screenplay"

module Smashcut
  # So you got a {Screenplay}, kid? Want a pdf from it?
  class PdfGenerator
    def initialize(screenplay)
      fail ArgumentError unless screenplay.is_a?(Screenplay)
      @screenplay = screenplay
    end

    # TODO: be much cleverer
    def write(path:)
      txt = screenplay.to_fountain
      Prawn::Document.generate(path) do
        text txt
      end
    end

    private

    attr_reader :screenplay
  end
end
