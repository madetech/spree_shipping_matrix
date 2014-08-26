# SpreeShippingMatrix

Advanced shipping calculator based on rules matrix for Spree.

[![Code Climate](https://codeclimate.com/github/madebymade/spree_shipping_matrix/badges/gpa.svg)](https://codeclimate.com/github/madebymade/spree_shipping_matrix)[![Test Coverage](https://codeclimate.com/github/madebymade/spree_shipping_matrix/badges/coverage.svg)](https://codeclimate.com/github/madebymade/spree_shipping_matrix)

## Installation

Add spree_shipping_matrix to your Gemfile:

```ruby
gem 'spree_shipping_matrix'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_shipping_matrix:install
```

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_shipping_matrix/factories'
```

## Credits

[![made](https://s3-eu-west-1.amazonaws.com/made-assets/googleapps/google-apps.png)][made]

Developed and maintained by [Made Tech][made]. Key contributions:

 * [Seb Ashton](https://github.com/SebAshton)
 * [Luke Morton](https://github.com/DrPheltRight)

## License

Copyright © 2014 Made Tech Ltd. It is free software, and may be
redistributed under the terms specified in the [MIT-LICENSE][license] file.

[made]: http://www.madetech.co.uk?ref=github&repo=spree_shipping_matrix
[license]: https://github.com/madebymade/cf-deploy/blob/master/LICENSE
