require 'smashcut'

def read_fountain(file)
  filename = File.expand_path "./spec/screenplays/" + file.gsub(" ", "_") + ".fountain"
  File.read filename
end

