require "prawn"
require "smashcut/screenplay"

module Smashcut
  # So you got a {Screenplay}, kid? Want a pdf from it?
  class PdfGenerator
    include Prawn::View

    def initialize(screenplay)
      fail ArgumentError unless screenplay.is_a?(Screenplay)
      @screenplay = screenplay
      font("Courier") do
        screenplay.elements.each do |element|
          element.add_to(self)
        end
      end
    end

    private

    attr_reader :screenplay
  end
end
