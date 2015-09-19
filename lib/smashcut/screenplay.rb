require "smashcut/screenplay/scene_heading"
require "smashcut/screenplay/action"

module Smashcut
  # TODO: add specs for this class
  # This is the object that represents a screenplay, and knows how to convert
  # to various formats
  class Screenplay
    attr_reader :elements

    def initialize(elements)
      @elements = elements
    end

    def scene_count
      elements.count { |el| el.is_a?(SceneHeading) }
    end
  end
end
