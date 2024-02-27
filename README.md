# WordCensored

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/word_censored`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'word_censored', '~> 0.1.8'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_censored

## Usage

Add this line to your class where you gonna use this gem:

```ruby
include WordCensored
```

then use it:

```ruby
filter('bad word')

> *** ****
```

## External Badword
If you want to add more badwords, create file `blacklist.json` in `public/assets` (create folder if you don't have) and follow the format:

```ruby
{
    "key": ["value", "value other ..."]
}
```

`"key"`  : is the first letter of your input string

`"value"`: must be in an array

`ex: "github", "github wordcensored"`

```ruby
{
    "g": ["github", "github wordcensored"]
}
```
<br/>
If your input string start with a number, `"key"` will be `"other"`

`ex: "2g1c"`

```ruby
{
    "other": ["2g1c"]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaelt0520/word_censored. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WordCensored project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/michaelt0520/word_censored/blob/master/CODE_OF_CONDUCT.md).
