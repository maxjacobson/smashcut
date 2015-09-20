require "parslet"
require "smashcut/screenplay"

module Smashcut
  # This class is responsible for taking the parsed fountain (hashes and arrays)
  # produced by {FountainParser} and seamlessly transforming that into
  # a rich {Screenplay} object, which eventually will be able to coerce itself
  # into various formats (fountain, pdf)
  class FountainTransform < Parslet::Transform
    rule(:screenplay => sequence(:elements)) { Screenplay.new(elements) }
    rule(:scene_heading => simple(:text)) { Screenplay::SceneHeading.new(text) }
    rule(:action => sequence(:phrases)) { Screenplay::Action.new(phrases) }
    rule(:plain => simple(:text)) { Screenplay::PlainTextPhrase.new(text) }
    rule(:italicized => simple(:text)) { Screenplay::ItalicizedPhrase.new(text) }
  end
end
