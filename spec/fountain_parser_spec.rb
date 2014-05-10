require_relative 'spec_helper'

=begin

  This spec is for testing the parser in full, including the root

  The other specs are for testing individual rules

=end

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
        first, second = parser.parse(text)
        first[:scene_heading].should eq "EXT. PARK - DAY"
        second[:action].should eq "A large extended family enjoys a picnic."
      end

    end

    describe 'dialogue' do
      let(:text) do
        "EXT. CARNIVAL - NIGHT\n\nMAX walks between the games.\n\nMAX\nWhoa"
      end

      it 'can parse this scene' do
        parser.should parse text
      end

      it 'can annotate this scene' do
        first, second, third = parser.parse(text)
        first[:scene_heading].should eq "EXT. CARNIVAL - NIGHT"
        second[:action].should eq "MAX walks between the games."
        third[:dialogue][:character_name].should eq "MAX"
        third[:dialogue][:speech].should eq "Whoa"
      end
    end

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
