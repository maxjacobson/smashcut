require "parslet"
require "smashcut/screenplay"

module Smashcut
  # This class is responsible for taking the parsed fountain (hashes and arrays)
  # and seamlessly transforming that into rich objects
  class FountainTransform < Parslet::Transform
    rule(:screenplay => sequence(:elements)) { Screenplay.new(elements) }
    rule(:action => simple(:text)) { Screenplay::Action.new(text) }
    rule(:scene_heading => simple(:text)) { Screenplay::SceneHeading.new(text) }
  end
end
