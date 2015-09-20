require "smashcut/screenplay/scene_heading"
require "smashcut/screenplay/action"

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
  end
end
