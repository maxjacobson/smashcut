require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser

    root(:screenplay)

    rule(:screenplay) do
      (
        screenplay_element >>
        line_break.maybe >>
        line_break.maybe
      ).repeat(1)
    end

    rule(:screenplay_element) do
      action |
      scene_heading |
      dialogue_block
    end

    rule(:line_break) do
      str("\n")
    end

    rule(:dot) do
      str('.')
    end

    rule(:scene_openers) do
      dot |
      str('ext.') |
      str('EXT.') |
      str('int.') |
      str('INT.') |
      str('est.') |
      str('EST.')
    end

    rule(:scene_heading) do
      (
        scene_openers >>
        line_break.absent? >>
        match("[a-zA-Z\s\-]").repeat(1)
      ).as(:scene_heading)
    end

    rule(:character_name) do
      match("[A-Z ]").repeat(1) >>
      line_break
    end

    rule(:dialogue_speech) do
      match("[a-zA-Z\s\.\(\)\,0-9\?]").repeat(1) >>
      line_break.maybe >>
      line_break.maybe
    end

    rule(:dialogue_block) do
      character_name >>
      line_break >>
      action >>
      line_break.maybe >>
      line_break.maybe
    end

    rule(:action) do
      scene_openers.absent? >>
      match("[a-zA-Z\s\.\(\)\,0-9\?\:\-]").repeat(1).as(:action) >>
      line_break.maybe >>
      line_break.maybe
    end

    # TODO remove this
    # we want output now so we know what the parser is thinking
    # when there are errors -- why did the parser fail? we can learn from this
    # and also when there aren't -- what did it think it saw there?
    require 'awesome_print'
    def parse(text)
      begin
        tokens = super(text)
        puts "success! parsed the following text into the following-following tokens:"
        puts text
        ap tokens
        puts "* " * 10
        tokens
      rescue Parslet::ParseFailed => error
        puts error.cause.ascii_tree
        raise error
      end
    end
  end
end

