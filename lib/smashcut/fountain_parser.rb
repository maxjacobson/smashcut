require "parslet"
require "smashcut/fountain_emphasis"

module Smashcut
  # This class parses fountain text and annotates what it finds
  # Meant to be used in conjunction with {FountainTransform}, which transforms
  # that annotated input into a rich {Screenplay} object.
  class FountainParser < Parslet::Parser
    # entry-point to the parser
    root(:screenplay)

    # screenplay is a bunch of elements spaced out with 2 linebreaks
    # TODO: maybe it should be 2-or-more linebreaks
    rule(:screenplay) do
      (screenplay_element >>
       line_break.maybe >>
       line_break.maybe).repeat(1).as(:screenplay)
    end

    # these are all the different parts that make up a screenplay
    rule(:screenplay_element) do
      scene_heading | dialogue | action
    end

    # simple rules
    rule(:line_break) { str("\n") }
    rule(:double_line_break) { line_break >> line_break }
    rule(:dot) { str(".") }
    rule(:space) { str(" ") }
    rule(:hash) { str('#') }
    rule(:bang) { str("!") }
    rule(:spiral) { str("@") }
    rule(:opening_parenthesis) { str("(") }
    rule(:closing_parenthesis) { str(")") }
    rule(:star) { str("*") }

    # TODO: explain what is happening here
    rule(:scene_openers) do
      %w( i/e int/ext int./ext ext int est ).map do |opener|
        opener.split("").map do |char|
          match["#{char.downcase}#{char.upcase}"]
        end.reduce(:>>)
      end.reduce(:|)
    end

    rule(:scene_number) do
      space.maybe >> hash >> anything_but("#").as(:scene_number) >> hash
    end

    rule(:anything_but_scene_number) do
      anything_but("#", "\n")
    end

    rule(:leading_dot_scene_heading) do
      dot >> anything_but_scene_number.as(:scene_heading) >> scene_number.maybe
    end

    rule(:whitelisted_scene_openers_scene_heading) do
      (scene_openers >> dot.maybe >> space >> anything_but_scene_number)
        .as(:scene_heading) >> scene_number.maybe
    end

    rule(:scene_heading) do
      leading_dot_scene_heading | whitelisted_scene_openers_scene_heading
    end

    rule(:spiral_character) do
      spiral >> anything_but("\n").as(:character)
    end

    rule(:no_spiral_character) do
      anything_but("a-z", "\n").as(:character)
    end

    rule(:character) do
      spiral_character | no_spiral_character
    end

    rule(:line) do
      (emphasized_phrase | plain_phrase).repeat(1).as(:line)
    end

    rule(:dialogue) do
      character >>
        (line_break >>
          (parenthetical >>
            line_break).maybe >>
            line).repeat(1).as(:lines) >>
        line_break.maybe
    end

    rule(:parenthetical) do
      (opening_parenthesis >>
       anything_but(")") >>
       closing_parenthesis).as(:parenthetical)
    end

    rule(:action) do
      (emphasized_phrase | plain_phrase).repeat(1).as(:action)
    end

    rule(:plain_phrase) do
      dynamic do |source, _context|
        if (index = source.match(stuff_then_emphasis))
          # saw an emphasis ahead, so just gonna eat up until that
          current_bytepos = source.bytepos
          plain_segment = source.consume(index).to_s
          source.bytepos = current_bytepos
          str(plain_segment).as(:plain)
        else
          # did not see a coming emphasis, so just gonna gobble up the rest of
          # the line
          anything_but("\n").as(:plain)
        end
      end
    end

    # whichever chars were used at the start, the reverse should end it
    rule(:emphasized_phrase) do
      emphasis_delimiter.capture(:open_emphasis) >> dynamic do |_src, context|
        open_emphasis = context.captures[:open_emphasis].to_s
        close_emphasis = open_emphasis.reverse
        anything_but("\n", close_emphasis).as(:emphasized_text) >>
          str(close_emphasis).as(:emphasis)
      end
    end

    private

    def stuff_then_emphasis
      FountainEmphasis.instance.stuff_then_emphasis_pattern
    end

    def anything_but(*chars)
      match["^#{chars.join}"].repeat(1)
    end

    # this makes every permutation of emphasis characters and makes a rule that
    # matches any of them
    # sorted by length so the longer ones have higher precedence
    def emphasis_delimiter
      return @emphasis_delimiter if defined?(@emphasis_delimiter)
      @emphasis_delimiter = FountainEmphasis.instance.longlist
                            .map { |delimeter| str(delimeter) }
                            .reduce(:|)
    end
  end
end
