# mcoenv

## Installation

    $ gem install mco_env

## Usage

Create any number of `~/.mcollective-*` directories with the appropriate configuration for your environments.

List configured environments:

    $ mcoenv
       bar
       baz
       foo
     * system

Change local environment (creates a `.mco-environment` file in the current directory):

    $ mcoenv local foo
    $ mcoenv
       bar
       baz
     * foo
       system

Then run Marionette Collective commands:

    $ mco ping                            # `mco ping --config ~/.mcollective-foo/client.cfg`
    $ mco rpc service status service=sshd # `mco rpc --config ~/.mcollective-foo/client.cfg service status service=sshd`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smortex/mco_env. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the McoEnv project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/smortex/mco_env/blob/master/CODE_OF_CONDUCT.md).
