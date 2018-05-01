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
$ bundle install
```

Or install it yourself as:
```bash
$ gem install unity
```

## Setup
Install the migrations if you want to override:
```bash
rake unity:install:migrations
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

Create initializer `config/initializers/unity.rb` with braintree credentials:
```ruby
require "unity"

Unity::BraintreeGateway.configure_braintree(
  environment: ENV["BRAINTREE_ENVIRONMENT"],
  merchant_id: ENV["BRAINTREE_MERCHANT_ID],
  public_key: ENV["BRAINTREE_PUBLIC_KEY"],
  private_key: ENV["BRAINTREE_PRIVATE_KEY"],
)

Unity.user_class = "User"
```

Add your Braintree Plans to the database:
```ruby
Unity::SubscriptionPlan.create!(
  gateway_id: "monthly_subscription",
  period: "1", # correlates to number of months in billing cycle
  price: "19.95",
)
```

Add `plan-credit` discount to braintree for billing cycle changes.

If you want to use stripe, add a hook to create the stripe customer
before you create a subscription.  For example, if you use devise,
in your registrations controller:

```
module Users
  class RegistrationsController < Devise::RegistrationsController
    after_action :create_stripe_customer, only: [:create]

    private

    def create_stripe_customer
      return if resource.errors.any?
      Unity::StripeGateway::CustomerCreator.call!(resource)
    end
  end
end
```

## Testing Engine

* Install stripe-mock
`brew install stripe/stripe-mock/stripe-mock`
`brew services start stripe-mock`
`rspec spec`


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
