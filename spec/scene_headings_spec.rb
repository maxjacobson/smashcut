require_relative 'spec_helper'

describe Smashcut::FountainParser do
  describe '#scene_heading' do
    let(:parser) { Smashcut::FountainParser.new.scene_heading }

    describe 'leading dot scene headings' do
      let(:text) { ".IN THE WOODS AT NIGHT" }
      it 'parses leading dot scene headings' do
        expect(parser).to parse text
      end
      it 'annotates and discards the dot' do
        token = parser.parse text
        expect(token[:scene_heading]).to eq "IN THE WOODS AT NIGHT"
      end
    end

    describe 'acceptable scene heading openers' do
      after(:each) do
        expect(parser).to parse @scene_heading
        token = parser.parse(@scene_heading)
        expect(token[:scene_heading]).to eq @scene_heading
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
      it 'can parse int/ext' do
        @scene_heading = 'int/ext convertible - day'
      end
    end

    describe 'scene headings with scene numbers' do
      let(:text) { 'EXT. HIKING TRAIL - DAY #1.#' }
      it 'can parse these' do
        expect(parser).to parse text
      end
      it 'knows which part is which' do
        token = parser.parse(text)
        expect(token[:scene_heading]).to eq 'EXT. HIKING TRAIL - DAY'
        expect(token[:scene_number]).to eq '1.'
      end
    end

    describe 'edge cases' do
      it 'only looks at leading dots, not trailing dots' do
        expect(parser).to_not parse 'The end.'
      end
      it 'should allow for characters named Esteban' do
        expect(parser).to_not parse 'Esteban walked down the sidewalk'
      end
    end

  end
end

