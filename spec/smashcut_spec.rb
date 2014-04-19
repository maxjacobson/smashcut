require_relative 'spec_helper'

describe Smashcut do
  describe '#parse' do

    it 'can parse a scene heading' do
      text = read_fountain 'just a scene heading'
      screenplay = Smashcut.new(text)
      expect { screenplay.tokens }.to_not raise_error
    end

    it 'can parse a scene heading with action' do
      text = read_fountain 'scene heading with action'
      screenplay = Smashcut.new(text)
      expect { screenplay.tokens }.to_not raise_error
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
