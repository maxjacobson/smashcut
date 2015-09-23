require "parslet"
require "smashcut/screenplay"

module Smashcut
  # This class is responsible for taking the parsed fountain (hashes and arrays)
  # produced by {FountainParser} and seamlessly transforming that into
  # a rich {Screenplay} object, which eventually will be able to coerce itself
  # into various formats (fountain, pdf)
  class FountainTransform < Parslet::Transform
    rule(:screenplay => sequence(:elements)) { Screenplay.new(elements) }

    rule(:scene_heading => simple(:text)) do
      Screenplay::SceneHeading.new(text.to_s)
    end

    rule(:action => sequence(:segments)) do
      Screenplay::Action.new(segments)
    end

    rule(:plain => simple(:text)) do
      Screenplay::UnemphasizedPhrase.new(text.to_s)
    end

    rule(:emphasized_text => simple(:text), :emphasis => simple(:emphasis)) do
      Screenplay::EmphasizedPhrase.new(text.to_s, emphasis.to_s)
    end

    rule(:character => simple(:character), :line => simple(:line)) do
      Screenplay::Line.new(character.to_s, line.to_s)
    end
  end
end
