RSpec.describe "spec_helper" do
  it "can read files" do
    screenplay = read_fountain("just a scene heading")
    expect(screenplay).to eq "EXT. PARK - DAY\n"
  end
end
