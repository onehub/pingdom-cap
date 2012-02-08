require 'ruby-debug'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

$LOAD_PATH << File.join(PROJECT_ROOT, "lib")

Bundler.require(:default, :development)

require 'pingdom_cap'

RSpec.configure do |config|
  config.mock_with :mocha
end

# WebMock.disable_net_connect!

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :webmock
end
