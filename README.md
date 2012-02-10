# pingdom-cap

pingdom-cap provides Capistrano tasks that can pause and unpause Pingdom checks.

For example, during a deploy, you probably don't want an email from Pingdom telling
you that your server is unavailable.

## Install

Add the pingdom-cap gem to your Gemfile:

    gem 'pingdom-cap'

Then from your project's RAILS_ROOT, and in your development environment, run:

    bundle install

## Usage

You may configure pingdom_cap with Capistrano variables or with environment variables.

Capistrano variables method: Set the following variables in your Capistrano deploy.rb script:

    set :pingdom_username,   'john@example.com'
    set :pingdom_password,   '123456'
    set :pingdom_key,        'your-pingdom-key'
    set :pingdom_check_name, 'check-name'

Environment variables way: Set the environment variables PINGDOM_USERNAME, PINGDOM_PASSWORD,
PINGDOM_KEY, and PINGDOM_CHECK_NAME.

The environment variables will take priority over the Capistrano variables, providing a means
to override.

NOTE: To acquire an API key for Pingdom, go here: https://pp.pingdom.com/index.php/member/api/restadd

(The Pingdom docs say: The key "is supposed to be unique on an application basis, not user basis.
This means that if you produce an application and then distribute it to the public, all users
of this application should use the same application key" (http://www.pingdom.com/services/api-documentation-rest/).
However, since Github projects are typically forked, we don't supply our key, and consider your
use of this gem to be a separate application. So get your own key.)

With these set, you can now type

    cap pingdom:pause
    cap pingdom:unpause

The first command with pause the check for 'check-name' and the second will unpause
the same check. Additionally, there is a task that will dump the status of a check
to the console:

    cap pingdom:status

Or you can use before and/or after hooks to trigger these tasks as needed:

    before 'deploy:migrations', 'pingdom:pause'
    after 'deploy:migrations',  'pingdom:unpause'

## Bonus: Command-line application

The gem ships with a command-line application named: pingdom-cap

The usage is:

    pingdom-cap check-name [status | pause | unpause]

To set the username, password, and key, use the environment variables as described above.

We added the command-line application because sometimes things go wrong. For example, it
may happen that Pingdom is broken, and your attempt to "unpause" fails. If that happens,
you probably want a means to unpause manually; in that case, use the command-line application.

## Testing

To run the specs,

    bundle exec rake

The Cucumber integration tests are all marked with @slow_process and are excluded in the rake task because they conduct a real round-trip with the server. To run them, set the environment variables (as above) and run Cucumber directly. For example,

		PINGDOM_CHECK_NAME="check-name" PINGDOM_USERNAME="john@example.com" \
		PINGDOM_PASSWORD="123456" PINGDOM_KEY="your-pingdom-key" bundle exec cucumber

The specs use the VCR gem to verify HTTP requests and responses. To re-create the fixtures:

		rm fixtures/cassettes/*    
		PINGDOM_CHECK_NAME="check-name" PINGDOM_USERNAME="john@example.com" \
		PINGDOM_PASSWORD="123456" PINGDOM_KEY="your-pingdom-key" bundle exec rake

If you fork and generate new VCR cassettes, either don't check them in or obfuscate them,
because they will contain your credentials.

## Contributing to pingdom-cap
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Iora Health. See LICENSE.txt for further details.
