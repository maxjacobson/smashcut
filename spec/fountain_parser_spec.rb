require_relative 'spec_helper'

describe Smashcut::FountainParser do
  let(:parser) { Smashcut::FountainParser.new }
  describe '#parse' do

    describe 'scene headings' do

      describe 'simple scene heading' do
        let(:text) { 'EXT. PARK - DAY' }

        it 'can consume this text' do
          expect(parser).to parse text
        end
        it 'can understand this text' do
          tokens = parser.parse(text)
          expect(tokens.first[:scene_heading]).to eq "EXT. PARK - DAY"
        end
      end

      describe 'the white list of scene openers' do

        describe 'leading-dot scene headings' do
          let(:text) { '.IN THE WOODS' }
          it 'can consume this text' do
            expect(parser).to parse text
          end
          it 'can understand this text' do
            tokens = parser.parse(text)
            expect(tokens.first[:scene_heading]).to eq "IN THE WOODS"
          end
        end

        describe 'the rest of the white list' do
          after(:each) do
            expect(parser).to parse @scene_heading
            expect( parser.parse(@scene_heading).first[:scene_heading] ).to eq @scene_heading
          end

          it 'can parse INT.' do
            @scene_heading = "INT. APARTMENT - NIGHT"
          end

          it 'can parse int.' do
            @scene_heading = 'int. apartment - day'
          end

          it 'can parse EXT.' do
            @scene_heading = 'EXT. PARK - NIGHT'
          end

          it 'can parse ext.' do
            @scene_heading = 'ext. space - forever'
          end

          it 'can parse INT without a dot' do
            @scene_heading = 'INT MALL - NIGHT'
          end

          it 'can parse I/E.' do
            @scene_heading = 'I/E. CONVERTIBLE / HIGHWAY - DAY'
          end

        end

        describe 'scene numbers' do
          let(:text) { "EXT. HIKING TRAIL - DAY #1.#" }

          it 'can parse scene headings with scene numbers' do
            expect(parser).to parse text
          end

          it 'knows which part is which' do
            tokens = parser.parse(text)
            expect(tokens[0][:scene_heading]).to eq "EXT. HIKING - TRAIL - DAY"
            expect(tokens[0][:scene_number]).to eq "1."
          end

        end

      end

      it 'does not think that trailing dot lines are scene headings' do
        expect(parser.parse('The end.').first[:action]).to eq "The end."
      end
    end

    describe 'action' do

      let(:text) { read_fountain 'scene heading with action' }

      it 'recognizes action following a scene heading' do
        expect(parser).to parse text
      end

      it 'knows which part is the scene heading and which part is the action' do
        tokens = parser.parse(text)
        expect(tokens[0][:scene_heading]).to eq "EXT. PARK - DAY"
        expect(tokens[1][:action]).to eq "A large extended family enjoys a picnic."
      end

    end

    describe 'character'

    describe 'dialogue' do
      it 'can parse a scene with simple dialogue' do
        text = read_fountain 'scene with simple dialogue'
        expect(parser).to parse text
      end
    end

    describe 'parenthetical' do
      it 'can parse a scene with parenthetical dialogue' do
        text = read_fountain 'scene with parenthetical dialogue'
        expect(parser).to parse text
      end
    end

    describe 'dual dialogue'

    describe 'lyrics'

    describe 'transition' do

      it 'can parse a scene with a transition to another scene' do
        text = read_fountain 'scene with transition'
        expect(parser).to parse text
      end

    end

    describe 'centered text'

    describe 'emphasis'

    describe 'title page'

    describe 'page breaks'

    describe 'punctuation'

    describe 'line breaks'

    describe 'indenting'

    describe 'notes'

    describe 'boneyard'

    describe 'sections and synopses'

    describe 'error handling'


  end
end
