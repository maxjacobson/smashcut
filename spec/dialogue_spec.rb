require_relative 'spec_helper'

describe Smashcut::FountainParser.new.dialogue do
  let(:dialogue) { Smashcut::FountainParser.new.dialogue }

  context 'with parentheticals' do

    describe "simple parentheticals" do

      let(:text) do
        read_fountain("simple dialogue with parenthetical").chomp
      end

      it 'can parse dialogue with parentheticals' do
        dialogue.should parse text
      end

      it 'can annotate dialogue with parentheticals' do
        token = dialogue.parse(text)[:dialogue]
        token[:character_name].should eq "BUD"
        token[:parenthetical].should eq "(stoned)"
        token[:speech].should eq "Whoa, show me that again..."
      end

    end

  end

  context 'without parentheticals' do
    describe 'simple dialogue' do
      let(:text) { "MAX\nWhat time is your train?" }

      it 'can parse simple dialogue' do
        dialogue.should parse text
      end

      it 'can annotate simple dialogue' do
        token = dialogue.parse(text)[:dialogue]
        token[:character_name].should eq "MAX"
        token[:speech].should eq "What time is your train?"
      end

    end
  end

end

