# smashcut

[![Build Status](https://travis-ci.org/maxjacobson/smashcut.svg?branch=master)](https://travis-ci.org/maxjacobson/smashcut)

This project helps convert [Fountain](http://fountain.io/syntax)-formatted
screenplays to PDF. It's a work in progress. The plan is to release it via
[RubyGems](http://rubygems.org) (and maybe some package managers) when it's more
useful.

smashcut uses [parslet](https://github.com/kschiess/parslet) to help parse the
fountain input and transform it into a rich Screenplay object. That object can
be used to produce a PDF (using [prawn](https://github.com/prawnpdf/prawn/) to
produce the PDF). It can also be used to produce a Fountain document, and *in
theory* could be taught to produce other formats like HTML or FDX. I'm not
currently interested in implementing those, but can imagine it would be useful.

### Installation

Because this is not useful yet I haven't pushed it to the rubygems site. If
you'd like to try it, you can follow these steps:

* `git clone git@github.com:maxjacobson/smashcut.git`
* `cd smashcut`
* `bundle install`
* `rake install`

At this point, the gem is installed on your system and you can require it from
your ruby programs or from within irb.

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
