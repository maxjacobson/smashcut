require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser
    rule(:line_break) { match("\n") }
    rule(:scene_heading) { match("[A-Z \-\. ]").repeat(1) >> line_break.maybe >> line_break.maybe }
    rule(:character_name) { match("[A-Z ]").repeat(1) >> line_break }
    rule(:dialogue_speech) { match("[a-zA-Z\s\.\(\)\,0-9\?]").repeat(1) >> line_break.maybe >> line_break.maybe }
    rule(:dialogue_block) { character_name >> line_break >> action >> line_break.maybe >> line_break.maybe }
    rule(:action) { match("[a-zA-Z\s\.\(\)\,0-9]").repeat(1) >> line_break.maybe >> line_break.maybe }
    rule(:screenplay_element) { scene_heading | dialogue_block | action }
    rule(:screenplay) { (screenplay_element >> line_break.maybe >> line_break.maybe).repeat(1) }
    root(:screenplay)

    def parse(text)
      begin
        super(text)
      rescue Parslet::ParseFailed => error
        puts error.cause.ascii_tree
        raise error
      end
    end
  end
end

