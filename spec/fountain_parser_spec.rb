require_relative 'spec_helper'

describe Smashcut::FountainParser do
  let(:parser) { Smashcut::FountainParser.new }
  describe '#parse' do

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
