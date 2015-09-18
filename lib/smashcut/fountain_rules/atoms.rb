class Smashcut
  module FountainRules
    module Atoms
      include Parslet

      rule(:line_break) do
        str("\n")
      end

      rule(:dot) do
        str(".")
      end

      rule(:space) do
        str(" ")
      end

      rule(:hash) do
        str('#')
      end

      rule(:bang) do
        str("!")
      end

      rule(:spiral) do
        str("@")
      end

      rule(:opening_parenthesis) do
        str("(")
      end

      rule(:closing_parenthesis) do
        str(")")
      end
    end
  end
end
