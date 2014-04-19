# smashcut

## Goals

### parse screenplays

* parse screenplays written in Fountain (<http://fountain.io/syntax>)
* comply to the spec as much as possible
* probably use parslet ([about][1], [slides][2]) as the parsing engine
* have tons of [tests][3] to help guide the way

[1]: http://kschiess.github.io/parslet/
[2]: https://speakerdeck.com/promptworks/writing-dsls-with-parslet-nyc-dot-rb
[3]: http://rspec.info/

### generate useful output

* generate HTML and PDF output
* probably use [prawn][4] as the PDF generating library, because it allows very fine control
* have tons of tests to help guide the way -- if prawn has tests for its PDFs, smashcut can learn from them

[4]: http://prawnpdf.org/

## boilerplate provided by `bundle gem smashcut`

### Installation

Add this line to your application's Gemfile:

    gem 'smashcut'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smashcut

### Usage

TODO: Write usage instructions here

### Contributing

1. Fork it ( https://github.com/[my-github-username]/smashcut/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
