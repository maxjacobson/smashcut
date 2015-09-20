module Smashcut
  RSpec.describe Screenplay::Action do
    let(:action) { described_class.new(phrases) }

    describe "#to_fountain" do
      context "when there is one unemphasized phrase" do
        let(:phrases) { [Screenplay::UnemphasizedPhrase.new("hello")] }
        it do
          expect(action.to_fountain).to eq "hello"
        end
      end

      context "when there is some following emphasis" do
        let(:phrases) do
          [Screenplay::UnemphasizedPhrase.new("hello "),
           Screenplay::EmphasizedPhrase.new("world", "***")]
        end

        it do
          expect(action.to_fountain).to eq "hello ***world***"
        end
      end
    end

    # TODO: implement specs for this one (it's indirectly tested elsewhere)
    describe "#=="
  end
end
