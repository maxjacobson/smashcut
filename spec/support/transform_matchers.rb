RSpec::Matchers.define :produce_screenplay do |*simple_expected_elements|
  match do |fountain_text|
    # create rich screenplay from plain string
    tree = Smashcut::FountainParser.new.parse(fountain_text)
    screenplay = Smashcut::FountainTransform.new.apply(tree)

    # create screenplay from simple hash
    rich_expected_elements = simple_expected_elements.map do |(klass, text)|
      Smashcut::Screenplay.const_get(klass).new(text)
    end

    screenplay.elements.zip(rich_expected_elements).all? do |(a, b)|
      a.class == b.class && a.text == b.text
    end
  end
end
