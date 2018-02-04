# Unity
A Ruby on Rails Engine to quickly add subscription support to your application.
This is a work in progress and will start off supporting Braintree.  I will
also be adding support for Stripe and possibly other payment processors.  In the
future this may also expand to support transactions.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'unity'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install unity
```

Migrate the database to build subscription and subscription_plan tables:
```bash
rake db:migrate
```

Mount engine in `config/routes.rb`:
```ruby
Rails.application.routes.draw do
  mount Unity::Engine, at: "/"
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
