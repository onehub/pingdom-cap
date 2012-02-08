require 'spec_helper'

describe PingdomCap::Capistrano do
  subject { PingdomCap::Capistrano }
  let(:io) { StringIO.new }
  let(:configuration) do
    Capistrano::Configuration.new.tap do |config|
      config.dry_run = true
      config.set(:pingdom_check_name, ENV['PINGDOM_CHECK_NAME'])
      config.set(:pingdom_username,   ENV['PINGDOM_USERNAME'])
      config.set(:pingdom_password,   ENV['PINGDOM_PASSWORD'])
      config.set(:pingdom_key,        ENV['PINGDOM_KEY'])
      logger = Capistrano::Logger.new(:output => io)
      logger.level = Capistrano::Logger::MAX_LEVEL
      config.logger = logger
    end
  end

  before(:each) do
    subject.load_into(configuration)
  end

  it "should define pingdom:pause" do
    configuration.find_task('pingdom:pause').should_not be_nil
  end
  it "should define pingdom:unpause" do
    configuration.find_task('pingdom:unpause').should_not be_nil
  end
  it "should log when calling pingdom:pause" do
    configuration.find_and_execute_task('pingdom:pause')
    io.string.include?('** Pingdom: paused').should be_true
  end
  it "should log when calling pingdom:pause" do
    configuration.find_and_execute_task('pingdom:unpause')
    io.string.include?('** Pingdom: unpaused').should be_true
  end
end
