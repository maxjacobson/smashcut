require_relative 'spec_helper'

describe Smashcut do
  describe '#parse' do

    describe 'scene headings' do
      it 'can parse a scene heading' do
        text = "EXT. PARK - DAY"
        screenplay = Smashcut.new(text)
        expect(screenplay.tokens.first[:slug]).to eq "EXT. PARK - DAY"
      end

      it 'knows valid scene openers' do
        expect do
          Smashcut::FountainParser.new.scene_openers.parse "."
        end.to_not raise_error
      end

      it 'can parse lower case scene headings' do
        text = "ext. park - day"
        screenplay = Smashcut.new(text)
        expect(screenplay.tokens.first[:slug]).to eq "ext. park - day"
      end

      it 'can parse leading-dot scene headings' do
        text = ".outside by the lake - night"
        screenplay = Smashcut.new(text)
        expect(screenplay.tokens.first[:slug]).to eq ".outside by the lake - night"
      end

      it 'does not think that trailing dot lines are scene headings' do
        text = "The end."
        screenplay = Smashcut.new(text)
        expect(screenplay.tokens.first[:action]).to eq "The end."
      end
    end

    it 'can parse a scene heading with action' do
      text = read_fountain 'scene heading with action'
      screenplay = Smashcut.new(text)
      expect(screenplay.tokens[0][:slug]).to eq "EXT. PARK - DAY"
      expect(screenplay.tokens[1][:action]).to eq "A large extended family enjoys a picnic."
    end

    it 'can parse a scene with simple dialogue' do
      text = read_fountain 'scene with simple dialogue'
      screenplay = Smashcut.new(text)
      expect { screenplay.tokens }.to_not raise_error
    end

    it 'can parse a scene with parenthetical dialogue' do
      text = read_fountain 'scene with parenthetical dialogue'
      screenplay = Smashcut.new(text)
      expect { screenplay.tokens }.to_not raise_error
    end

    it 'can parse a scene with a transition to another scene' do
      text = read_fountain 'scene with transition'
      screenplay = Smashcut.new(text)
      expect { screenplay.tokens }.to_not raise_error
    end

  end
end
