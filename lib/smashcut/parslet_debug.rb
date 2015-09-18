require "awesome_print"

module Parslet
  module Atoms
    class Entity
      def parse(text)
        token = super(text)
        ap token
        token
      rescue Parslet::ParseFailed => error
        puts error.cause.ascii_tree
        raise error
      end
    end
  end
end

class Smashcut
  class FountainParser
    def parse(text)
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
