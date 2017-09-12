# ResponseEncryption

This gem can be used to encrypt the attributes of your rails application or then entired body. It can be integrated with jsonapi-resources, active-model-serializer or just with a normal Rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'response_encryption'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install response_encryption

## Usage

### JSON API resources
- Install and configure the `jsonapi-resource` gem in your project
- add an initializer with the ResponseEncryption config

```ruby
ResponseEncryption.configure do |config|
  config.encryption_strategy = :encrypted_attributes
  config.serializer_gem = :jsonapi_resources
  config.algothim = 'AES'
  config.algorithm_key_length = '256'
  config.block_cipher_mode = 'CBC'
end
```

- include the `ResponseEncryption::ActsAsEncryptionController` module into your `ApplicationController`
- include the `include ResponseEncryption::EncryptAttributes` your XResource
- add the fields that you want to encrypt as parameters in the your XResource

```ruby
encrypted_attrs :field1, field2, ... , fieldn
```
### Active model serializer
- Install and configure the `active_model_serializers` gem in your project
- add an initializer with the ResponseEncryption config

```ruby
ResponseEncryption.configure do |config|
  config.encryption_strategy = :encrypted_attributes
  config.serializer_gem = :active_model_serializers
  config.algothim = 'AES'
  config.algorithm_key_length = '256'
  config.block_cipher_mode = 'CBC'
end
```

- include the `ResponseEncryption::ActsAsEncryptionController` module into your `ApplicationController`
- include the `include ResponseEncryption::EncryptAttributes` your XSerializer
- add the fields that you want to encrypt as parameters in the your XSerializer

```ruby
encrypted_attrs :field1, field2, ... , fieldn
```
## TODO
- explain ResponseEncryption config parameters
- show examples
- add encryption_strategy for encrypt_body
- test other algorithms to encrypt
- implement responses without any serializer

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/response_encryption. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ResponseEncryption project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/response_encryption/blob/master/CODE_OF_CONDUCT.md).
