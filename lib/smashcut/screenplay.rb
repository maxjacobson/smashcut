require "smashcut/fountain_parser"
require "smashcut/fountain_transform"

require "smashcut/screenplay/concerns/screenplay_component"
require "smashcut/screenplay/scene_heading"
require "smashcut/screenplay/action"
require "smashcut/screenplay/line"
require "smashcut/screenplay/unemphasized_phrase"
require "smashcut/screenplay/emphasized_phrase"

require "smashcut/pdf_generator"

module Smashcut
  # This is the object that represents a screenplay, which can offer some info
  # about the screenplay and convert it to various formats (eventually)
  class Screenplay
    attr_reader :elements

    def initialize(elements)
      @elements = elements
    end

    # TODO: add ::from_pdf
    # TODO: add ::from_fdx
    def self.from_fountain(fountain)
      FountainTransform.new.apply(
        FountainParser.new.parse(fountain))
    end

    def to_pdf(path:)
      PdfGenerator.new(self).save_as(path)
    end

    # How many scenes are in this screenplay?
    def scene_count
      elements.count { |el| el.is_a?(SceneHeading) }
    end

    # TODO: test me and improve
    def to_fountain
      elements.map(&:to_fountain).join("\n\n")
    end

    def ==(other)
      elements.zip(other.elements).all? do |a, b|
        a == b
      end
    end
  end
end
