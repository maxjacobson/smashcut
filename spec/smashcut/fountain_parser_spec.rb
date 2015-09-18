RSpec.describe Smashcut::FountainParser.new.root do
  let(:parser) { Smashcut::FountainParser.new.root }
  describe '#parse' do
    describe "action" do
      let(:text) do
        "EXT. PARK - DAY\n\nA large extended family enjoys a picnic."
      end

      it "recognizes action following a scene heading" do
        expect(parser).to parse text
      end

      it "knows which part is the scene heading and which part is the action" do
        first, second = parser.parse(text)
        expect(first[:scene_heading]).to eq "EXT. PARK - DAY"
        expect(second[:action]).to eq "A large extended family enjoys a picnic."
      end
    end

    describe "dialogue" do
      let(:text) do
        "EXT. CARNIVAL - NIGHT\n\nMAX walks between the games.\n\nMAX\nWhoa"
      end

      it "can parse this scene" do
        expect(parser).to parse text
      end

      it "can annotate this scene" do
        first, second, third = parser.parse(text)
        expect(first[:scene_heading]).to eq "EXT. CARNIVAL - NIGHT"
        expect(second[:action]).to eq "MAX walks between the games."
        expect(third[:dialogue][:character_name]).to eq "MAX"
        expect(third[:dialogue][:speech]).to eq "Whoa"
      end
    end
    describe "anything_but_scene_number" do
      let(:rule) { Smashcut::FountainParser.new.anything_but_scene_number }

      it "can parse a simple string" do
        expect(rule).to parse "Hello"
      end

      it "can not parse a string with a scene number after it" do
        expect(rule).not_to parse "Hello #1#"
      end
    end

    describe "anything_but" do
      let(:parser) { Smashcut::FountainParser.new }
      it "should not parse input with excluded characters" do
        rule = parser.anything_but("a")
        expect(rule).not_to parse "veronica"
      end

      it "should parse input without exlcuded characters" do
        rule = parser.anything_but("q")
        expect(rule).to parse "veronica"
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

    describe "scene_number" do
      let(:scene_number) { Smashcut::FountainParser.new.scene_number }

      describe "the syntax" do
        it "can parse normal ones" do
          expect(scene_number).to parse " #1#"
        end
        it "can parse without a space" do
          expect(scene_number).to parse "#1#"
        end
        it "can parse repeating numbers" do
          expect(scene_number).to parse "#1111#"
        end
        it "can parse non-digit characters" do
          expect(scene_number).to parse "#two#"
        end
        it "can parse a few other characters" do
          expect(scene_number).to parse "#1.#"
          expect(scene_number).to parse "#1-1#"
        end
      end

      describe "annotation" do
        it "can capture digits" do
          expect(scene_number.parse("#1#")[:scene_number]).to eq "1"
        end
        it "can capture repeating digits" do
          expect(scene_number.parse("#111#")[:scene_number]).to eq "111"
        end
      end
    end

    describe "action" do
      let(:action) { Smashcut::FountainParser.new.action }
      it "recognizes action" do
        expect(action).to parse "He walked down the street."
      end
      it "annotates correctly" do
        action_text = action.parse("Gum stuck to his shoe")[:action]
        expect(action_text).to eq "Gum stuck to his shoe"
      end
    end

    describe "dual dialogue"
    describe "lyrics"
    describe "transition"
    describe "centered text"
    describe "emphasis"
    describe "title page"
    describe "page breaks"
    describe "punctuation"
    describe "line breaks"
    describe "indenting"
    describe "notes"
    describe "boneyard"
    describe "sections and synopses"
    describe "error handling"
  end
end
