# frozen_string_literal: true
# Some helper mehods related to reading example files from the file system
module ScreenplayFileReading
  def read_fountain(file)
    filename = File.expand_path(
      "./spec/support/screenplays/#{file.tr(' ', '_')}.fountain"
    )
    File.read(filename)
  end
end

RSpec.configure do |config|
  config.include ScreenplayFileReading
end
