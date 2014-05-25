require_relative 'spec_helper'

describe Smashcut::FountainParser.new.character_name do

  let(:character_name) { Smashcut::FountainParser.new.character_name }

  context 'with leading @' do
    it 'can parse names with leading @' do
      character_name.should parse "@MAX"
    end
    it 'can parse names with leading @ with lower case letters' do
      character_name.should parse "@Max Jacobson"
    end
    it 'annotates the name without the @' do
      token = character_name.parse "@Max Jacobson"
      token[:character_name].should eq "Max Jacobson"
    end
  end

  context 'without leading @' do

    it 'can parse names in all capitals' do
      character_name.should parse "MAX"
    end

    it 'can parse names in all capitals with spaces' do
      character_name.should parse "MAX JACOBSON"
    end

    it 'can not parse names with lower case characters' do
      character_name.should_not parse "Max Jacobson"
    end

    it 'can parse names with numbers' do
      character_name.should parse "COP 2"
    end

  end
end
