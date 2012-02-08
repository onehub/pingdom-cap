require 'capistrano'

module PingdomCap
  module Capistrano

    def self.pingdom(configuration, operation)
   end

    def self.load_into(configuration)
      configuration.load do
        namespace :pingdom do

          def self.param(name)
            ENV[name.to_s.upcase] || fetch(name)
          end
          def pingdom(configuration, operation)
            if configuration.dry_run
              logger.info "DRY RUN: pingdom_cap #{check_name} #{operation} not actually run."
            else
               check_name = param(:pingdom_check_name)
               username   = param(:pingdom_username)
               password   = param(:pingdom_password)
               key        = param(:pingdom_key)
               client = PingdomCap::Client.new(username: username, password: password, key: key)
              client.send(operation, check_name)
            end
          end

          desc "Pause checks at Pingdom"
          task :pause, :except => { :no_release => true } do
            pingdom(configuration, 'pause')
          end
          desc "Unpause checks at Pingdom"
          task :unpause, :except => { :no_release => true } do
            pingdom(configuration, 'unpause')
          end

        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  PingdomCap::Capistrano.load_into(Capistrano::Configuration.instance)
end
