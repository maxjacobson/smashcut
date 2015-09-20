RSpec.describe Smashcut::FountainParser do
  describe "the entire parser come together" do
    let(:parser) { described_class.new }

    context "when the screenplay is a scene heading and some action" do
      let(:text) { read_fountain "scene heading and action" }

      xit "should parse the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. PARK - DAY" },
            { :action => [
              { :plain => "A large extended family enjoys a picnic." }] }])
      end
    end

    context "when the screenplay is a scene heading, action, and dialogue" do
      let(:text) { read_fountain "scene heading action and dialogue" }

      xit "should parse the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. CARNIVAL - NIGHT" },
            { :action => [{ :plain => "MAX walks between the games." }] },
            { :dialogue => {
              :character_name => "MAX", :speech => "Whoa" } }])
      end
    end
  end

  describe "individual rules" do
    describe "anything_but_scene_number" do
      let(:rule) { Smashcut::FountainParser.new.anything_but_scene_number }

      it "can parse a simple string" do
        expect(rule).to parse("Hello").as("Hello")
      end

      it "can not parse a string with a scene number after it" do
        expect(rule).not_to parse("Hello #1#")
      end
    end

    describe "character_name" do
      let(:rule) { Smashcut::FountainParser.new.character_name }

      context "with leading spiral (@) and all caps" do
        it "strips out the spiral" do
          expect(rule).to parse("@MAX").as(:character_name => "MAX")
        end
      end

      context "with leading spiral, mixed case, and space" do
        it do
          expect(rule).to parse("@Max Jacobson")
            .as(:character_name => "Max Jacobson")
        end
      end

      context "when the text is all caps" do
        it do
          expect(rule).to parse("MAX").as(:character_name => "MAX")
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

    describe "dialogue" do
      let(:dialogue) { Smashcut::FountainParser.new.dialogue }

      context "with parentheticals" do
        describe "simple parentheticals" do
          let(:text) do
            read_fountain("simple dialogue with parenthetical").chomp
          end

          it "can parse dialogue with parentheticals" do
            expect(dialogue).to parse text
          end

          it "can annotate dialogue with parentheticals" do
            token = dialogue.parse(text)[:dialogue]
            expect(token[:character_name]).to eq "BUD"
            expect(token[:parenthetical]).to eq "(stoned)"
            expect(token[:speech]).to eq "Whoa, show me that again..."
          end
        end
      end

      context "without parentheticals" do
        describe "simple dialogue" do
          let(:text) { "MAX\nWhat time is your train?" }

          it "can parse simple dialogue" do
            expect(dialogue).to parse text
          end

          it "can annotate simple dialogue" do
            token = dialogue.parse(text)[:dialogue]
            expect(token[:character_name]).to eq "MAX"
            expect(token[:speech]).to eq "What time is your train?"
          end
        end
      end
    end

    describe "parenthetical" do
      let(:parenthetical) do
        Smashcut::FountainParser.new.parenthetical
      end

      describe "happy path" do
        let(:text) { "(quiet)" }

        it "should parse parentheticals" do
          expect(parenthetical).to parse text
        end

        it "should annotate parentheticals" do
          expect(parenthetical.parse(text)[:parenthetical]).to eq text
        end
      end

      describe "sad path" do
        it "should not parse non parentheticals" do
          expect(parenthetical).not_to parse "Hello"
        end
      end
    end

    describe "scene_heading" do
      let(:scene_heading) { Smashcut::FountainParser.new.scene_heading }

      describe "leading dot scene headings" do
        let(:text) { ".IN THE WOODS AT NIGHT" }

        it "parses leading dot scene headings" do
          expect(scene_heading).to parse text
        end
        it "annotates and discards the dot" do
          token = scene_heading.parse text
          expect(token[:scene_heading]).to eq "IN THE WOODS AT NIGHT"
        end
      end

      describe "acceptable scene heading openers" do
        after(:each) do
          expect(scene_heading).to parse @scene_heading
          token = scene_heading.parse(@scene_heading)
          expect(token[:scene_heading]).to eq @scene_heading
        end
        it "can parse INT." do
          @scene_heading = "INT. APARTMENT - NIGHT"
        end
        it "can parse int." do
          @scene_heading = "int. apartment - day"
        end
        it "can parse EXT." do
          @scene_heading = "EXT. PARK - NIGHT"
        end
        it "can parse ext." do
          @scene_heading = "ext. space - forever"
        end
        it "can parse INT without a dot" do
          @scene_heading = "INT MALL - NIGHT"
        end
        it "can parse I/E." do
          @scene_heading = "I/E. CONVERTIBLE - DAY"
        end
        it "can parse int/ext" do
          @scene_heading = "int/ext convertible - day"
        end
        it "can parse int./ext" do
          @scene_heading = "INT./EXT. TRUCK - DAY"
        end
      end

      describe "scene headings with scene numbers" do
        let(:text) { 'EXT. HIKING TRAIL - DAY#1#' }
        it "can parse these" do
          expect(scene_heading).to parse text
        end
        it "knows which part is which" do
          token = scene_heading.parse(text)
          expect(token[:scene_heading]).to eq "EXT. HIKING TRAIL - DAY"
          expect(token[:scene_number]).to eq "1"
        end

        it 'can parse scene numbers which aren\'t digits' do
          expect(scene_heading).to parse "INT. HIKING DOME - DAY #TWO#"
        end
      end

      describe "edge cases" do
        it "only looks at leading dots, not trailing dots" do
          expect(scene_heading).not_to parse "The end."
        end
        it "should allow for characters named Esteban" do
          expect(scene_heading).not_to parse "Esteban walked down the sidewalk"
        end
      end
    end

    describe "scene_number" do
      let(:scene_number) { Smashcut::FountainParser.new.scene_number }

      context "when there is a leading space" do
        it do
          expect(scene_number).to parse(" #1#").as(:scene_number => "1")
        end
      end

      context "when there is no leading space" do
        it do
          expect(scene_number).to parse("#1#").as(:scene_number => "1")
        end
      end

      context "when there are repeating numbers" do
        it do
          expect(scene_number).to parse("#1111#").as(:scene_number => "1111")
        end
      end

      context "when there are non digit characters" do
        it do
          expect(scene_number).to parse("#two#").as(:scene_number => "two")
        end
      end

      context "when there are is a period" do
        it do
          expect(scene_number).to parse("#1.#").as(:scene_number => "1.")
        end
      end

      context "when there is a dash" do
        it do
          expect(scene_number).to parse("#1-1#").as(:scene_number => "1-1")
        end
      end
    end

    # describe "plain_phrase" do
    #   let(:rule) { Smashcut::FountainParser.new.plain_phrase }
    #   context "when the text is a plain word" do
    #     it do
    #       expect(rule).to parse("Hello").as(:plain => "Hello")
    #     end
    #   end

    #   context "when the text is two words, with a space" do
    #     it do
    #       expect(rule).to parse("Hello world").as(:plain => "Hello world")
    #     end
    #   end

    #   context "when the text contains some characters from not English" do
    #     let(:text) { "左轉上噴泉" }
    #     it do
    #       expect(rule).to parse(text).as(:plain => text)
    #     end
    #   end

    #   context "when the text is a few words, including punctuation" do
    #     let(:text) { "Hello, world! My friend... :)" }
    #     it do
    #       expect(rule).to parse(text).as(:plain => text)
    #     end
    #   end

    #   context "when the text is followed by emphasized text" do
    #     let(:text) { "Hello *my friend!*" }
    #     it do
    #       expect(rule).to parse(text).as(:plain => "Hello ")
    #     end
    #   end
    # end

    describe "emphasized_phrase" do
      let(:rule) { Smashcut::FountainParser.new.emphasized_phrase }

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
      let(:rule) { Smashcut::FountainParser.new.action }

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

      context "when the text has some emphasis in the middle" do
        let(:text) { "And then... _HOLY SHIT_ a puppy!" }
        it do
          expect(rule).to parse(text)
            .as(:action => [
              { :plain => "And then... " },
              { :emphasized_text => "HOLY SHIT", :emphasis => "_" },
              { :plain => " a puppy." }])
        end
      end
    end
  end
end
