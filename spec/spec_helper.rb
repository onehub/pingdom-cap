require 'ruby-debug'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

$LOAD_PATH << File.join(PROJECT_ROOT, "lib")

Bundler.require(:default, :development)

require 'pingdom_cap'

RSpec.configure do |config|
  config.mock_with :mocha
end
