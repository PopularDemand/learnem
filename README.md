# Learnem
Let's get dangerous.

***

This gem has come preloaded with minimal Flashcards and Quotes to get you started. Enjoy!

## Installation

Install this gem via command line:
```
  $ gem install learnem
 ```
## Usage

####To see all options:
```
  $ learnem
```
####To begin a flashcard session:
```
  $ learnem flashem [FLAG]
```
The possible flags are `-b` for begin or `-a` to add a new card. You *must* use one.

#### To see a nice quote:
```
  $ learnem quotem [FLAG]
```
The possible flags are `-r` to read one or `-a` to add a new quote. You *must* use one.

#### To quickly open Ruby Docs:
```
  $ learnem docs [CLASS] [METHOD]
```
Class and method are required. Currently only supports Ruby 2.3.1 documentation.

#### To view the main menu:
```
  $ learnem main_menu
```

#### In app help:
```
  $learnem [COMMAND] --help
```
## Development

After checking out the repo, run `bundle install` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PopularDemand/learnem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

