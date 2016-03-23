# frozen_string_literal: true
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

    # a regex for identifying whether a line starts out with unemphasized text
    # and is followed by emphasized text. for emphasis, should match any
    # combination of *, **, and _
    #
    # (if the emphasized text begins with, e.g., _*, it must end with the
    # reverse: *_
    #
    # the emphasized text part is a "zero-width positive look-ahead assertion"
    # because of the ?= -- so, its presence is required for a string to satisfy
    # the regex, but when a string is matched against the pattern, only the
    # unemphasized text is captured
    def stuff_then_emphasis_pattern
      /#{unemphasized_phrase_regex_str}(?=#{emphasized_phrase_regex_str})/
    end

    private

    def shortlist
      @emphasis_characters ||= ["*", "**", "_"]
    end

    # the question mark here makes this "non-greedy", because we want to match
    # the first emphasis, not the last one
    def unemphasized_phrase_regex_str
      ".+?"
    end

    # every permutation of emphasis, followed by anything, followed by the
    # appropriate closing emphasis (the reverse of the opening emphasis)
    # each one is separated by pipes -- or -- because we don't care which one
    # is matched
    def emphasized_phrase_regex_str
      longlist.map do |opening_emphasis|
        opening = Regexp.escape(opening_emphasis)
        closing = Regexp.escape(opening_emphasis.reverse)
        # using ?: here because we don't need to capture this group
        "(?:#{opening}.+#{closing})"
      end.join("|")
    end
  end
end
