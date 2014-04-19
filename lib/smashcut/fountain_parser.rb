require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser
    rule(:line_break) { match("\n") }
    rule(:scene_heading) { match("[A-Z \-\. ]").repeat(1) >> line_break.maybe }
    root(:scene_heading)

    #def parse(text)
    #  begin
    #    super(text)
    #  rescue Exception => e
    #    puts e
    #  end
    #end
  end
end

