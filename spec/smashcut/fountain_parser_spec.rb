RSpec.describe Smashcut::FountainParser.new.root do
  let(:parser) { Smashcut::FountainParser.new }

  describe "the entire parser come together" do
    context "when the screenplay is a scene heading and some action" do
      let(:text) { read_fountain "scene heading and action" }

      it "should parse the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. PARK - DAY" },
            { :action => "A large extended family enjoys a picnic." }])
      end
    end

    context "when the screenplay is a scene heading, action, and dialogue" do
      let(:text) { read_fountain "scene heading action and dialogue" }

      it "should parse the screenplay" do
        expect(parser).to parse(text)
          .as(:screenplay => [
            { :scene_heading => "EXT. CARNIVAL - NIGHT" },
            { :action => "MAX walks between the games." },
            { :dialogue => { :character_name => "MAX",
                             :speech => "Whoa" } }])
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
        expect(rule).not_to parse "Hello #1#"
      end
    end

    describe "character_name" do
      let(:character_name) { Smashcut::FountainParser.new.character_name }

      context "with leading @" do
        it "can parse names with leading @" do
          expect(character_name).to parse "@MAX"
        end
        it "can parse names with leading @ with lower case letters" do
          expect(character_name).to parse "@Max Jacobson"
        end
        it "annotates the name without the @" do
          token = character_name.parse "@Max Jacobson"
          expect(token[:character_name]).to eq "Max Jacobson"
        end
      end

      context "without leading @" do
        it "can parse names in all capitals" do
          expect(character_name).to parse "MAX"
        end

        it "can parse names in all capitals with spaces" do
          expect(character_name).to parse "MAX JACOBSON"
        end

        it "can not parse names with lower case characters" do
          expect(character_name).not_to parse "Max Jacobson"
        end

        it "can parse names with numbers" do
          expect(character_name).to parse "COP 2"
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

    describe "#scene_number" do
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

    describe "action" do
      let(:action) { Smashcut::FountainParser.new.action }

      it "recognizes action" do
        expect(action).to parse("He walked down the street.")
          .as(:action => "He walked down the street.")
      end
    end
  end
end
