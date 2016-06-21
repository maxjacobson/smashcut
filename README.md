# smashcut

[![Build Status](https://travis-ci.org/maxjacobson/smashcut.svg?branch=master)](https://travis-ci.org/maxjacobson/smashcut)
[![Code Climate](https://codeclimate.com/github/maxjacobson/smashcut/badges/gpa.svg)](https://codeclimate.com/github/maxjacobson/smashcut)
[![Test Coverage](https://codeclimate.com/github/maxjacobson/smashcut/badges/coverage.svg)](https://codeclimate.com/github/maxjacobson/smashcut/coverage)
[![Issue Count](https://codeclimate.com/github/maxjacobson/smashcut/badges/issue_count.svg)](https://codeclimate.com/github/maxjacobson/smashcut)

This project helps convert [Fountain](http://fountain.io/syntax)-formatted
screenplays to PDF. It's a work in progress. The plan is to release it via
[RubyGems](http://rubygems.org) (and maybe homebrew???) when it's more useful.

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

### release process

(Haven't actually done this yet, but) to release a new version of the gem, you
will need to:

* decide what is the new version number
* edit the version.rb file with a new version number
* edit the CHANGELOG.md file to describe the new release, and make sure there's
  an "unreleased" section at the top for future unreleased changes.
* The commit these changes
* run `bundle exec rake release`, which will generate a git tag, push the tag to
  GitHub, create a new `.gem` file under the `pkg` folder, and release that pkg
  to rubygems.org
* create a new GitHub release
  (<https://github.com/maxjacobson/smashcut/releases>) describing the changes in
  the new version

### Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/maxjacobson/smashcut>. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

A small change

Hm, yea?
