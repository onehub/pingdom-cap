require 'faraday'
require 'faraday_middleware'
require 'awesome_print'

module PingdomCap
  class Client
    BASE_SERVER_ADDRESS = "https://api.pingdom.com/api/2.0"
    OPTIONS = {
      :url => BASE_SERVER_ADDRESS
    }
    REQUIRED_OPTIONS = [ :key, :url, :username, :password ]

    attr_reader :connection

    def initialize(options = {})
      options = OPTIONS.merge(options)
      raise "Options #{REQUIRED_OPTIONS.join(', ')} are required" if REQUIRED_OPTIONS.any? { |op| options[op].nil? }
      headers = { 'App-Key' => options[:key] }
      @connection = Faraday::Connection.new(:url => options[:url], :headers => headers) do |builder|
        builder.response :logger if options[:logger]
        builder.adapter Faraday.default_adapter
        builder.request  :url_encoded
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
      end
      @connection.basic_auth(options[:username], options[:password])
    end

    def status(name)
      puts "Status for Pingdom '#{name}'"
      ap get_detailed_check_information(name_to_checkid(name)).to_hash, :plain => true
    end

    def pause(name)
      puts "Pausing Pingdom '#{name}'"
      check_pause(name_to_checkid(name))
    end

    def unpause(name)
      puts "Unpausing Pingdom '#{name}'"
      check_unpause(name_to_checkid(name))
    end

    private

    def check_pause(checkid)
      modify_check(checkid, { :paused => true })
    end

    def check_unpause(checkid)
      modify_check(checkid, { :paused => false })
    end

    def name_to_checkid(name)
      unless @name_to_checkid
        @name_to_checkid = {}
        response = get_check_list.body
        response['checks'].each { |m| @name_to_checkid[m.name] = m.id }
      end
      raise "There is no check for '#{name}'" unless @name_to_checkid[name]
      @name_to_checkid[name]
    end

    # Since these methods are functional and don't do REST, the names come from the API docs

    def get_detailed_check_information(checkid)
      # http://www.pingdom.com/services/api-documentation-rest/#MethodGet+Detailed+Check+Information
      connection.get("checks/#{checkid}").body.check
    end

    def modify_check(checkid, params)
      # http://www.pingdom.com/services/api-documentation-rest/#MethodModify+Check
      response = connection.put("checks/#{checkid}") do |req|
        # Next line shouldn't be necessary; apparently url_encoded only triggers for POST
        req.body = Faraday::Utils.build_nested_query params
      end
    end

    def get_check_list
      # http://www.pingdom.com/services/api-documentation-rest/#MethodGet+Check+List
      connection.get('checks')
    end
  end
end
