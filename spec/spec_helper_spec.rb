describe "spec_helper" do
  it "can read files" do
    screenplay = read_fountain("just a scene heading")
    screenplay.should eq "EXT. PARK - DAY\n"
  end
end
