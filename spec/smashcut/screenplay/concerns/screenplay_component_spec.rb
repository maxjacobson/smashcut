module Smashcut
  class Screenplay
    class FooComponent
      include ScreenplayComponent

      def initialize(str)
        @str = str
      end

      def to_fountain
        @str
      end
    end

    RSpec.describe ScreenplayComponent do
      it { expect(FooComponent.new("yo")).to eq FooComponent.new("yo") }
    end
  end
end
