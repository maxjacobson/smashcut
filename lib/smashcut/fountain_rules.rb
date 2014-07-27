require "smashcut/fountain_rules/helpers"
require "smashcut/fountain_rules/atoms"
require "smashcut/fountain_rules/dialogue"
require "smashcut/fountain_rules/scene_headers"
require "smashcut/fountain_rules/action"

class Smashcut
  module FountainRules
    include Helpers
    include Atoms
    include SceneHeaders
    include Dialogue
    include Action
  end
end

