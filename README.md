# smashcut

[![Build Status](https://travis-ci.org/maxjacobson/smashcut.svg?branch=master)](https://travis-ci.org/maxjacobson/smashcut)

## Goals

### parse screenplays

* parse screenplays written in Fountain (<http://fountain.io/syntax>)
* comply to the spec as much as possible
* use parslet ([about][1], [slides][2]) as the parsing engine
* have tons of [tests][3] to help guide the way

[1]: http://kschiess.github.io/parslet/
[2]: https://speakerdeck.com/promptworks/writing-dsls-with-parslet-nyc-dot-rb
[3]: http://rspec.info/

### generate useful output

* generate HTML and PDF output
* probably use [prawn][4] as the PDF generating library, because it allows very
  fine control and doesn't require non-ruby dependencies
* have tons of tests to help guide the way -- if prawn has tests for its PDFs,
  smashcut can learn from them

[4]: http://prawnpdf.org/

### Installation

Because this is not useful yet I haven't pushed it to the rubygems site. If
you'd like to try it, you can follow these steps:

* `git clone git@github.com:maxjacobson/smashcut.git`
* `cd smashcut`
* `bundle install`
* `rake install`

### tests and style

If you'd like to run the tests and linter, just run `bundle exec rake`. Another
option you have is to run `bundle exec guard`, which will auto-run tests when
you edit files.

### docs

If you'd like to browse the docs, run `bundle exec yard server -r` which spins
up a server you can visit in your browser at <http://localhost:8808>. When
adding inline documentation (comments above classes, methods, etc) please use
the yard syntax.

### Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/maxjacobson/smashcut>. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.
