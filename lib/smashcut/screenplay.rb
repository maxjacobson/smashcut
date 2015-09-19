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
  end
end
