require "smashcut/version"
require "smashcut/fountain_parser"

class Smashcut
  attr_reader :text
  def initialize(text)
    @text = text
  end

  def tokens
    @tokens ||= FountainParser.new.parse(text)
  end

end
