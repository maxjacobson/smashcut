module Smashcut
  RSpec.describe Screenplay do
    describe "#scene_count" do
      let(:screenplay) { described_class.new(elements) }

      context "when there is one scene heading" do
        let(:elements) { [Screenplay::SceneHeading.new("INT. CAFE - DAY")] }
        it do
          expect(screenplay.scene_count).to eq 1
        end
      end

      context "when there are two scene headings" do
        let(:elements) do
          [Screenplay::SceneHeading.new("INT. CAFE - DAY"),
           Screenplay::SceneHeading.new("INT. APARTMENT - NIGHT")]
        end
        it do
          expect(screenplay.scene_count).to eq 2
        end
      end
    end
  end
end
