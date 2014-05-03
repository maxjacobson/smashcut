require_relative 'spec_helper'

describe Smashcut::FountainParser.new.root do
  let(:parser) { Smashcut::FountainParser.new.root }
  describe '#parse' do

    describe 'action' do

      let(:text) do
        "EXT. PARK - DAY\n\nA large extended family enjoys a picnic."
      end

      it 'recognizes action following a scene heading' do
        parser.should parse text
      end

      it 'knows which part is the scene heading and which part is the action' do
        tokens = parser.parse(text)
        tokens[0][:scene_heading].should eq "EXT. PARK - DAY"
        tokens[1][:action].should eq "A large extended family enjoys a picnic."
      end

    end

    describe 'character'
    describe 'dialogue'
    describe 'parenthetical'
    describe 'dual dialogue'
    describe 'lyrics'
    describe 'transition'
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
