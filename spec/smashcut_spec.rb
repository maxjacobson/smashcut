RSpec.describe Smashcut do
  describe "::new, #text" do
    let(:smashcut) { Smashcut.new(text) }

    context "when the input ends with a newline" do
      let(:text) { "Hello World\n" }
      it "spits back the provided text" do
        expect(smashcut.text).to eq text
      end
    end

    context "when the input does not end with a newline" do
      let(:text) { "Hello World" }
      it "should add a newline" do
        expect(smashcut.text).to eq "Hello World\n"
      end
    end
  end
end
