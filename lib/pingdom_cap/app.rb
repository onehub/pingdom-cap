module PingdomCap
  class App
    def initialize
    end
    def run
      username = ENV['PINGDOM_USERNAME']
      password = ENV['PINGDOM_PASSWORD']
      key = ENV['PINGDOM_KEY']
      check_name = ARGV[0]
      operation = ARGV[1] || 'status'

      if check_name
        pingdom = PingdomCap::Client.new(:username => username, :password => password, :key => key)
        pingdom.send(operation, check_name)
      else
        puts "usage: pingdom-cap check-name [status | pause | unpause]"
      end
    end
  end
end
