# Some helpful rspec matchers from parslet
require "parslet/rig/rspec"

RSpec.describe Smashcut::FountainParser do
  describe "the entire parser come together" do
    let(:parser) { described_class.new }

    context "when the screenplay is a scene heading and some action" do
      let(:text) { read_fountain "scene heading and action" }

      it "parses the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. PARK - DAY" },
            { :action => [
              { :plain => "A large extended family enjoys a picnic." }] }])
      end
    end

    context "when the screenplay is a scene heading, action, and dialogue" do
      let(:text) { read_fountain "scene heading action and dialogue" }

      it "parses the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. CARNIVAL - NIGHT" },
            { :action => [{ :plain => "MAX walks between the games." }] },
            { :character => "MAX",
              :lines => [{ :line => [{ :plain => "Whoa" }] }] }])
      end
    end

    context "when the screenplay has multiple scenes, with transitions" do
      let(:text) { read_fountain "two scenes with a transition" }
      it do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. PARK - NIGHT" },
            { :action => [{
              :plain => "Max bicycles around the park. What is he running from?"
            }] },
            { :transition => "FADE TO:" },
            { :scene_heading => "INT. A CARDBOARD BOX - NIGHT" },
            { :action => [{
              :plain => "Max shrinks down real small."
            }] },
            { :centered => " LOL THE END " }
          ])
      end
    end

    context "when the screenplay has a title page" do
      let(:text) { read_fountain "screenplay with title page" }
      xit do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :title_page => {
              :Title => "Hardscrabble Road",
              :Credit => "Written by",
              :Author => "Max Jacobson"
            } },
            { :scene_heading => "EXT. A DUSTY ROAD - NIGHT" },
            { :action => [{ :plain => "A garbage man arrives on foot" }] }
          ])
      end
    end
  end

  describe "individual rules" do
    describe "anything_but_scene_number" do
      let(:rule) { described_class.new.anything_but_scene_number }

      it "can parse a simple string" do
        expect(rule).to parse("Hello").as("Hello")
      end

      it "can not parse a string with a scene number after it" do
        expect(rule).not_to parse("Hello #1#")
      end
    end

    describe "character" do
      let(:rule) { described_class.new.character }

      context "with leading spiral (@) and all caps" do
        it "strips out the spiral" do
          expect(rule).to parse("@MAX").as(:character => "MAX")
        end
      end

      context "with leading spiral, mixed case, and space" do
        it do
          expect(rule).to parse("@Max Jacobson")
            .as(:character => "Max Jacobson")
        end
      end

      context "when the text is all caps" do
        it do
          expect(rule).to parse("MAX").as(:character => "MAX")
        end
      end

      context "when the text is all caps with a space" do
        it do
          expect(rule).to parse "MAX JACOBSON"
        end
      end

      context "when the text is mixed case, without a leading spiral (@)" do
        it "can not parse names with lower case characters" do
          expect(rule).not_to parse("Max Jacobson")
        end
      end

      context "when the text has a number in it" do
        it do
          expect(rule).to parse "COP 2"
        end
      end
    end

    # TODO: test that it parses properly with emphasized text
    describe "dialogue" do
      let(:rule) { described_class.new.dialogue }

      context "when there is one parenthetical" do
        let(:text) do
          read_fountain("simple dialogue with parenthetical")
        end

        it do
          expect(rule).to parse(text)
            .as(:character => "BUD",
                :lines => [{ :parenthetical => "(stoned)",
                             :line => [
                               { :plain => "Whoa, show me that again..." }] }])
        end
      end

      context "when there are two parentheticals" do
        let(:text) { read_fountain "dialogue with multiple parentheticals" }

        it do
          expect(rule).to parse(text)
            .as(:character => "STEVE",
                :lines => [
                  { :parenthetical => "(wanly)",
                    :line => [
                      { :plain => "Everything is going dark..." }] },
                  { :parenthetical => "(beat)",
                    :line => [{ :plain => "Someone turn the lights on..." }] }])
        end
      end

      context "when there is no parenthetical" do
        let(:text) { "MAX\nWhat time is your train?" }

        it "can parse simple dialogue" do
          expect(rule).to parse(text)
            .as(:character => "MAX",
                :lines => [
                  { :line => [
                    { :plain => "What time is your train?" }] }])
        end
      end
    end

    # TODO: snip out the parens from the parsed value
    describe "parenthetical" do
      let(:rule) { described_class.new.parenthetical }

      describe "happy path" do
        let(:text) { "(quiet)" }

        it "parses parentheticals" do
          expect(rule).to parse(text).as(:parenthetical => text)
        end
      end

      describe "sad path" do
        it "does not parse non-parentheticals" do
          expect(rule).not_to parse "Hello"
        end
      end
    end

    describe "scene_heading" do
      let(:rule) { described_class.new.scene_heading }

      describe "leading dot scene headings" do
        let(:text) { ".IN THE WOODS AT NIGHT" }

        it "parses leading dot scene headings" do
          expect(rule).to parse(text)
            .as(:scene_heading => "IN THE WOODS AT NIGHT")
        end
      end

      describe "acceptable scene heading openers" do
        shared_examples "valid scene heading" do
          it "parses the valid scene heading" do
            expect(rule).to parse(scene_heading)
              .as(:scene_heading => scene_heading)
          end
        end

        context "INT." do
          let(:scene_heading) { "INT. APARTMENT - NIGHT" }
          it_behaves_like "valid scene heading"
        end

        context "int." do
          let(:scene_heading) { "int. apartment - day" }
          it_behaves_like "valid scene heading"
        end

        context "EXT." do
          let(:scene_heading) { "EXT. PARK - NIGHT" }
          it_behaves_like "valid scene heading"
        end

        context "ext." do
          let(:scene_heading) { "ext. space - forever" }
          it_behaves_like "valid scene heading"
        end

        context "INT without dot" do
          let(:scene_heading) { "INT MALL - NIGHT" }
          it_behaves_like "valid scene heading"
        end

        context "I/E." do
          let(:scene_heading) { "I/E. CONVERTIBLE - DAY" }
          it_behaves_like "valid scene heading"
        end

        context "int/ext" do
          let(:scene_heading) { "int/ext convertible - day" }
          it_behaves_like "valid scene heading"
        end

        context "INT./EXT." do
          let(:scene_heading) { "INT./EXT. TRUCK - DAY" }
          it_behaves_like "valid scene heading"
        end
      end

      describe "scene headings with scene numbers" do
        let(:text) { 'EXT. HIKING TRAIL - DAY#1#' }
        it "can parse these" do
          expect(rule).to parse(text)
            .as(:scene_heading => "EXT. HIKING TRAIL - DAY",
                :scene_number => "1")
        end

        it 'can parse scene numbers which aren\'t digits' do
          # TODO: lose trailing space on scene heading
          expect(rule).to parse("INT. HIKING DOME - DAY #TWO#")
            .as(:scene_heading => "INT. HIKING DOME - DAY ",
                :scene_number => "TWO")
        end
      end

      describe "edge cases" do
        it "only looks at leading dots, not trailing dots" do
          expect(rule).not_to parse "The end."
        end

        it "allows for characters named Esteban" do
          expect(rule).not_to parse "Esteban walked down the sidewalk"
        end
      end
    end

    # TODO: transform these
    describe "scene_number" do
      let(:rule) { described_class.new.scene_number }

      context "when there is a leading space" do
        it do
          expect(rule).to parse(" #1#").as(:scene_number => "1")
        end
      end

      context "when there is no leading space" do
        it do
          expect(rule).to parse("#1#").as(:scene_number => "1")
        end
      end

      context "when there are repeating numbers" do
        it do
          expect(rule).to parse("#1111#").as(:scene_number => "1111")
        end
      end

      context "when there are non digit characters" do
        it do
          expect(rule).to parse("#two#").as(:scene_number => "two")
        end
      end

      context "when there are is a period" do
        it do
          expect(rule).to parse("#1.#").as(:scene_number => "1.")
        end
      end

      context "when there is a dash" do
        it do
          expect(rule).to parse("#1-1#").as(:scene_number => "1-1")
        end
      end
    end

    describe "plain_phrase" do
      let(:rule) { described_class.new.plain_phrase }

      context "when the text is a plain word" do
        it do
          expect(rule).to parse("Hello").as(:plain => "Hello")
        end
      end

      context "when the text is two words, with a space" do
        it do
          expect(rule).to parse("Hello world").as(:plain => "Hello world")
        end
      end

      context "when the text contains some characters from not English" do
        let(:text) { "左轉上噴泉" }
        it do
          expect(rule).to parse(text).as(:plain => text)
        end
      end

      context "when the text is a few words, including punctuation" do
        let(:text) { "Hello, world! My friend... :)" }
        it do
          expect(rule).to parse(text).as(:plain => text)
        end
      end
      context "when the text is followed by emphasized text" do
        let(:text) { "Hello *my friend!*" }
        it do
          expect(rule).to_not parse(text)
        end
      end
    end

    describe "emphasized_phrase" do
      let(:rule) { described_class.new.emphasized_phrase }

      context "when the text is surrounded by stars" do
        let(:text) { "*omg!*" }
        it do
          expect(rule).to parse(text)
            .as(:emphasized_text => "omg!", :emphasis => "*")
        end
      end

      context "when the text is just two stars" do
        let(:text) { "**" }
        it do
          expect(rule).to_not parse(text)
        end
      end

      context "when the text is surrounded by _" do
        let(:text) { "_lol omg_" }
        it do
          expect(rule).to parse(text)
            .as(:emphasized_text => "lol omg", :emphasis => "_")
        end
      end

      context "when the text is surrounded by *_" do
        let(:text) { "*_haha... wow_*" }
        it do
          expect(rule).to parse(text)
            .as(:emphasized_text => "haha... wow", :emphasis => "_*")
        end
      end

      context "when the text is surrounded by **" do
        let(:text) { "**Superlove is a great song.**" }
        it do
          expect(rule).to parse(text)
            .as(:emphasized_text => "Superlove is a great song.",
                :emphasis => "**")
        end
      end

      context "when the text is surrounded by ***" do
        let(:text) { "***There is a fish!***" }
        it do
          expect(rule).to parse(text)
            .as(:emphasized_text => "There is a fish!", :emphasis => "***")
        end
      end
    end

    describe "action" do
      let(:rule) { described_class.new.action }

      context "when the text is a simple sentence" do
        let(:text) { "He walked home." }
        it do
          expect(rule).to parse(text).as(:action => [{ :plain => text }])
        end
      end

      context "when the text is multiple actions" do
        let(:text) { "He was so happy.\n\nFor a time." }
        it do
          expect(rule).to_not parse(text)
        end
      end

      context "when the text has some emphasis in it at the beginning" do
        let(:text) { "*HOLY SHIT* there's a puppy." }
        it do
          expect(rule).to parse(text)
            .as(:action => [
              { :emphasized_text => "HOLY SHIT", :emphasis => "*" },
              { :plain => " there's a puppy." }])
        end
      end

      context "when the text has some emphasis at the end" do
        let(:text) { "And then... _HOLY SHIT_" }
        it do
          expect(rule).to parse(text)
            .as(:action => [
              { :plain => "And then... " },
              { :emphasized_text => "HOLY SHIT", :emphasis => "_" }])
        end
      end

      context "when the text has some emphasis in the middle" do
        let(:text) { "And then... _HOLY SHIT_ a puppy!" }
        it do
          expect(rule).to parse(text)
            .as(:action => [
              { :plain => "And then... " },
              { :emphasized_text => "HOLY SHIT", :emphasis => "_" },
              { :plain => " a puppy!" }])
        end
      end

      context "when the text has multiple emphasises" do
        let(:text) { "And then... _HOLY SHIT_ *a puppy!*" }
        it do
          expect(rule).to parse(text)
            .as(:action => [
              { :plain => "And then... " },
              { :emphasized_text => "HOLY SHIT", :emphasis => "_" },
              { :plain => " " },
              { :emphasized_text => "a puppy!", :emphasis => "*" }])
        end
      end
    end

    describe "transition" do
      let(:rule) { described_class.new.transition }

      context "when the text is all caps and ends in TO:" do
        let(:text) { "FADE TO:" }

        it do
          expect(rule).to parse(text).as(:transition => "FADE TO:")
        end
      end

      context "when the text isn't capitalized" do
        let(:text) { "fade to:" }
        it do
          expect(rule).to_not parse(text)
        end
      end

      context "when the text is some random uppercased word followed by TO:" do
        let(:text) { "LOL TO:" }
        it do
          expect(rule).to parse(text).as(:transition => "LOL TO:")
        end
      end

      context "when the text is a few uppercased words with TO:" do
        let(:text) { "LOL WOW TO:" }
        it do
          expect(rule).to parse(text).as(:transition => "LOL WOW TO:")
        end
      end
    end

    describe "centered text" do
      let(:rule) { described_class.new.centered_text }
      context "when the text is centered" do
        let(:text) { "> THE END <" }
        it do
          expect(rule).to parse(text).as(:centered => " THE END ")
        end
      end
    end

    # TODO: much more tests needed
    describe "title page" do
      let(:rule) { described_class.new.title_page }
      context "when there is a title" do
        let(:text) { "Title: Hardscrabble\n" }
        it do
          expect(rule).to parse(text, :trace => true).as(
            :title_page => [{
              :title => "Hardscrabble"
            }])
        end
      end
    end
  end
end
