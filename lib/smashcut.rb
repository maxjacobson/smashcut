require "smashcut/version"
require "smashcut/fountain_parser"

class Smashcut
  attr_reader :text
  def initialize(text)
    @text = text
    @text << "\n" unless @text.end_with?("\n")
  end

  def tokens
    @tokens ||= FountainParser.new.parse(text)
    puts @tokens.inspect
    @tokens
  end

end
