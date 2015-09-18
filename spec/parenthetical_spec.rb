describe Smashcut::FountainParser.new.parenthetical do
  let(:parenthetical) do
    Smashcut::FountainParser.new.parenthetical
  end

  describe 'happy path' do
    let(:text) { "(quiet)" }

    it 'should parse parentheticals' do
      parenthetical.should parse text
    end

    it 'should annotate parentheticals' do
      parenthetical.parse(text)[:parenthetical].should eq text
    end
  end

  describe 'sad path' do
    it 'should not parse non parentheticals' do
      parenthetical.should_not parse "Hello"
    end
  end
end
