# frozen_string_literal: true
module Smashcut
  RSpec.describe FountainEmphasis do
    let(:emphasis) { described_class.instance }

    describe "#longlist" do
      let(:list) { emphasis.longlist }

      it { expect(list.length).to eq 12 }
      it { expect(list.uniq).to match_array list }

      it "has a bunch of items in it" do
        list.each do |el|
          expect(el).to be_a String
          expect(1..4).to include el.length
        end
      end
    end

    describe "#stuff_then_emphasis_pattern" do
      let(:pattern) { emphasis.stuff_then_emphasis_pattern }
      let(:scanner) { StringScanner.new(text) }
      let(:match_index) { scanner.match?(pattern) }

      context "when the text has no emphasis in it" do
        let(:text) { "Hello world!" }
        it { expect(match_index).to be_nil }
      end

      context "when the text has an emphasis at the end" do
        let(:text) { "Hello *world*" }
        it { expect(match_index).to eq 6 }
      end

      context "when the text has multiple emphases" do
        let(:text) { "Hello *world* *lol*" }
        it { expect(match_index).to eq 6 }
      end
    end
  end
end
