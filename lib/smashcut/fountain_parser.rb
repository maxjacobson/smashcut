require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser
    rule(:line_break) { match("\n") }
    rule(:scene_heading) { match("[A-Z \-\. ]").repeat(1) >> line_break.maybe >> line_break.maybe >> action.maybe }
    rule(:action) { match("[a-zA-Z\s\.]").repeat(1) >> line_break.maybe >> line_break.maybe }
    root(:scene_heading)

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

