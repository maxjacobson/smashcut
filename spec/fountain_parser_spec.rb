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
          expect(tokens.first[:slug]).to eq "EXT. PARK - DAY"
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
            expect(tokens.first[:slug]).to eq "IN THE WOODS"
          end
        end

        describe 'the rest of the white list' do
          after(:each) do
            expect(parser).to parse @slug
            expect( parser.parse(@slug).first[:slug] ).to eq @slug
          end

          it 'can parse INT.' do
            @slug = "INT. APARTMENT - NIGHT"
          end

          it 'can parse int.' do
            @slug = 'int. apartment - day'
          end

          it 'can parse EXT.' do
            @slug = 'EXT. PARK - NIGHT'
          end

          it 'can parse ext.' do
            @slug = 'ext. space - forever'
          end

          it 'can parse INT without a dot' do
            @slug = 'INT MALL - NIGHT'
          end

          it 'can parse I/E.' do
            @slug = 'I/E. CONVERTIBLE / HIGHWAY - DAY'
          end

        end
      end


      it 'does not think that trailing dot lines are scene headings' do
        expect(parser.parse('The end.').first[:action]).to eq "The end."
      end
    end

    it 'can parse a scene heading with action' do
      text = read_fountain 'scene heading with action'
      expect(parser).to parse text
      tokens = parser.parse(text)
      expect(tokens[0][:slug]).to eq "EXT. PARK - DAY"
      expect(tokens[1][:action]).to eq "A large extended family enjoys a picnic."
    end

    it 'can parse a scene with simple dialogue' do
      text = read_fountain 'scene with simple dialogue'
      expect(parser).to parse text
    end

    it 'can parse a scene with parenthetical dialogue' do
      text = read_fountain 'scene with parenthetical dialogue'
      expect(parser).to parse text
    end

    it 'can parse a scene with a transition to another scene' do
      text = read_fountain 'scene with transition'
      expect(parser).to parse text
    end

  end
end
