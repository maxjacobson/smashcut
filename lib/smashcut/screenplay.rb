require "smashcut/screenplay/scene_heading"
require "smashcut/screenplay/action"
require "smashcut/screenplay/unemphasized_phrase"
require "smashcut/screenplay/emphasized_phrase"

module Smashcut
  # This is the object that represents a screenplay, which can offer some info
  # about the screenplay and convert it to various formats (eventually)
  class Screenplay
    attr_reader :elements

    def initialize(elements)
      @elements = elements
    end

    # How many scenes are in this screenplay?
    def scene_count
      elements.count { |el| el.is_a?(SceneHeading) }
    end

    def ==(other)
      elements.zip(other.elements).all? do |a, b|
        a == b
      end
    end
  end
end
