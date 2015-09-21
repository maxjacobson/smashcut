require "singleton"

module Smashcut
  # This one helps manage emphasis, e.g.
  #
  # The man removes his mask... _**IT'S HIS FATHER**_
  class FountainEmphasis
    include Singleton

    def longlist
      (1..shortlist.length).map do |amount_of_emphasizers|
        shortlist.permutation(amount_of_emphasizers).to_a.map(&:join)
      end.flatten.uniq.sort_by(&:length).reverse
    end

    def stuff_then_emphasis_pattern
      / #{unemphasized_phrase_regex_str}
        (?= #{emphasized_phrase_regex_str}) # followed by emphasized stuff
      /x
    end

    private

    def shortlist
      @emphasis_characters ||= ["*", "**", "_"]
    end

    def unemphasized_phrase_regex_str
      ".+?"
    end

    def emphasized_phrase_regex_str
      longlist.map do |opening_emphasis|
        opening = Regexp.escape(opening_emphasis)
        closing = Regexp.escape(opening_emphasis.reverse)
        "(?:#{opening}.+#{closing})"
      end.join("|")
    end
  end
end
