module Smashcut
  RSpec.describe Screenplay::EmphasizedPhrase do
    let(:text) { "lol" }
    let(:phrase) { described_class.new(text, emphasis) }

    describe "#italicized?" do
      context "when it is is italicized" do
        let(:emphasis) { "*" }
        it { expect(phrase).to be_italicized }
      end

      context "when it is not italicized" do
        let(:emphasis) { "**" }
        it { expect(phrase).to_not be_italicized }
      end

      context "when it is bold and italicized" do
        let(:emphasis) { "***" }
        it { expect(phrase).to be_italicized }
      end

      context "when it is bolded and underlined" do
        let(:emphasis) { "**_" }
        it { expect(phrase).to_not be_italicized }
      end
    end

    describe "underlined?" do
      context "when it is underlined" do
        let(:emphasis) { "_" }
        it { expect(phrase).to be_underlined }
      end

      context "when it is underlined and bolded" do
        let(:emphasis) { "_**" }
        it { expect(phrase).to be_underlined }
      end

      context "when it is not underlined" do
        let(:emphasis) { "***" }
        it { expect(phrase).to_not be_underlined }
      end
    end

    context "bolded?" do
      context "when it is bolded" do
        let(:emphasis) { "**" }
        it { expect(phrase).to be_bolded }
      end

      context "when it is merely italicized" do
        let(:emphasis) { "*" }
        it { expect(phrase).to_not be_bolded }
      end
    end

    describe "#to_fountain" do
      context "when the emphasis is *" do
        let(:emphasis) { "*" }
        it do
          expect(phrase.to_fountain).to eq "*lol*"
        end
      end

      context "when the emphasis is *_**" do
        let(:emphasis) { "*_**" }
        it do
          expect(phrase.to_fountain).to eq "*_**lol**_*"
        end
      end
    end
  end
end
