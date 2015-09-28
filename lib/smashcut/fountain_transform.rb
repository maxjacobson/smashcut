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

    rule(:line => sequence(:phrases)) do
      Screenplay::Line.new(phrases)
    end

    rule(:parenthetical => simple(:parenthetical)) do
      Screenplay::Parenthetical.new(parenthetical.to_s)
    end

    rule(:parenthetical => simple(:parenthetical), :line => sequence(:parts)) do
      Screenplay::LineWithParenthetical.new(parenthetical, parts)
    end

    rule(:character => simple(:character), :lines => sequence(:lines)) do
      Screenplay::Dialogue.new(Screenplay::Character.new(character.to_s), lines)
    end

    rule(:transition => simple(:transition)) do
      Screenplay::Transition.new(transition.to_s)
    end
  end
end
