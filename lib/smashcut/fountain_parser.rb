require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser

    rule(:line_break) { match("\n") }
    rule(:dot) { str('.') }

    rule(:scene_openers) { dot | str('ext.') | str('EXT.') | str('int.') | str('INT.') | str('est.') | str('EST.') }
    rule(:scene_heading) { ( scene_openers >> line_break.absent? >> match("[a-zA-Z\s\-]").repeat(1) ).as(:slug) }

    rule(:character_name) { match("[A-Z ]").repeat(1) >> line_break }
    rule(:dialogue_speech) { match("[a-zA-Z\s\.\(\)\,0-9\?]").repeat(1) >> line_break.maybe >> line_break.maybe }
    rule(:dialogue_block) { character_name >> line_break >> action >> line_break.maybe >> line_break.maybe }

    rule(:action) { scene_openers.absent? >> match("[a-zA-Z\s\.\(\)\,0-9\?\:\-]").repeat(1).as(:action) >> line_break.maybe >> line_break.maybe }


    rule(:screenplay_element) { action | scene_heading | dialogue_block }
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

