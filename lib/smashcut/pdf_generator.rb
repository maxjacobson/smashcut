require "prawn"
require "smashcut/screenplay"

module Smashcut
  # So you got a {Screenplay}, kid? Want a pdf from it?
  class PdfGenerator
    include Prawn::View

    def initialize(screenplay)
      fail ArgumentError unless screenplay.is_a?(Screenplay)
      @screenplay = screenplay
      go_for_it
    end

    private

    attr_reader :screenplay

    def go_for_it
      font("Courier") do
        screenplay.elements.each do |element|
          if element.is_a?(Screenplay::Line)
            text element.name, :align => :center
            text element.speech, :align => :center
          else
            text element.to_fountain
            move_down 5
          end
        end
      end
    end
  end
end
