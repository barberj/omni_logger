# OmniLogger

[![Code Climate](https://codeclimate.com/github/barberj/omni_logger/badges/gpa.svg)](https://codeclimate.com/github/barberj/omni_logger)

Log to multiple logs. Thanks and appreciation to @clowder for the original [gist](https://gist.github.com/clowder/3639600)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omni_logger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omni_logger

## Usage

    log_1 = Logger.new(STDOUT)
    log_2 = Logger.new(File.open('/tmp/foo', 'a'))

    omni_logger = OmniLogger.new(level: :warn, loggers: log_1)
    omni_logger.add_logger(log_2)

    omni_logger.warn('Something interesting happened.')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/barberj/omni_logger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
