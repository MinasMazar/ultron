# Ultron

    In a ruby script, there’s a keyword __END__ that for a long time I thought just marked anything after it as a comment. So I used to use it to store snippets and notes about the script that weren’t really needed inline. Then one day I stumbled across the DATA constant, and wondered what flaming magic it was.

Taken from [http://caiustheory.com/why-i-love-data/](http://caiustheory.com/why-i-love-data/)

*Ultron* helps to retrieve this data and update them. It's assumed the data are in [ *YAML* ](http://yaml.org/) format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ultron'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ultron

## Usage

Simple script

```ruby
require 'ultron'

# Get youtube urls in YAML format
vids = __ultron_data

# Do some stuff with data..
vids.each do |v|
  v[:title] ||= `youtube-dl -s --get-title #{v[:url]}`
end

# Now save data
__ultron_update

__END__
---
- :url: http://www.youtube.com/watch?v=umCVFVANdfs
- :url: http://www.youtube.com/watch?v=Se90eQhC7D0
- :url: http://www.youtube.com/watch?v=Zz-6BgsmYe4
- :url: http://www.youtube.com/watch?v=fJQHV3AT03w
```

At the end of this script the video should have titles

```ruby
require 'ultron'

# Get youtube urls in YAML format
vids = __ultron_data

# Do some stuff with data..
vids.each do |v|
  v[:title] ||= `youtube-dl -s --get-title #{v[:url]}`
end

# Now save data
__ultron_update

__END__
---
- :url: http://www.youtube.com/watch?v=umCVFVANdfs
  :title: |
    Brocken Moon - Mondfinsternis (Full Album)
- :url: http://www.youtube.com/watch?v=Se90eQhC7D0
  :title: |
    Cultes Des Ghoules - Henbane (2013) [Full Album]
- :url: http://www.youtube.com/watch?v=Zz-6BgsmYe4
  :title: |
    Abbath- Abbath (Full Album 2016) HD

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ultron.

