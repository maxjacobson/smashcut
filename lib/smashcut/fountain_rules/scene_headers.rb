class Smashcut
  module FountainRules
    module SceneHeaders
      include Parslet

      rule(:scene_openers) do
        %w( i/e int/ext int./ext ext int est ).map do |opener|
          opener.split("").map do |char|
            match["#{char.downcase}#{char.upcase}"]
          end.reduce(:>>)
        end.reduce(:|)
      end

      rule(:scene_number) do
        space.maybe >>
          hash >>
          anything_but("#").as(:scene_number) >>
          hash
      end

      rule(:anything_but_scene_number) do
        anything_but("#", "\n")
      end

      rule(:leading_dot_scene_heading) do
        dot >>
          anything_but_scene_number.as(:scene_heading) >>
          scene_number.maybe
      end

      rule(:whitelisted_scene_openers_scene_heading) do
        (
          scene_openers >>
          dot.maybe >>
          space >>
          anything_but_scene_number
        ).as(:scene_heading) >>
          scene_number.maybe
      end

      rule(:scene_heading) do
        leading_dot_scene_heading | whitelisted_scene_openers_scene_heading
      end
    end
  end
end
