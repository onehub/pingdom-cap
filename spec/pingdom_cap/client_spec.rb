require 'spec_helper'

describe PingdomCap::Client, '.new' do
  subject { PingdomCap::Client }
  it "should raise an error unless a key is specified" do
    lambda { subject.new(:key => nil) }.should raise_error
  end
  it "should raise an error unless a url is specified" do
    lambda { subject.new(:url => nil) }.should raise_error
  end
  it "should raise an error unless a username is specified" do
    lambda { subject.new(:username => nil) }.should raise_error
  end
  it "should raise an error unless a password is specified" do
    lambda { subject.new(:password => nil) }.should raise_error
  end
  it "should not raise an error when key, url, username, and password are specified" do
    lambda { subject.new(:key => 'some_key', :url => 'https://api.pingdom.com', :username => 'john@example.com', :password => '123456') }.should_not raise_error
  end
  it "should not raise an error when non-default options are missing" do
    lambda { subject.new(:key => 'some_key', :username => 'john@example.com', :password => '123456') }.should_not raise_error
  end
  it "should create a connection during initialization" do
    client = subject.new(:key => 'some_key', :username => 'john@example.com', :password => '123456')
    client.connection.should_not be_nil
  end
end

describe PingdomCap::Client do
  subject { PingdomCap::Client.new(
    :username => ENV['PINGDOM_USERNAME'] || 'john@example.com',
    :password => ENV['PINGDOM_PASSWORD'] || 'zzzzyyyyxxxxwwww',
    :key => ENV['PINGDOM_KEY'] || 'aaaabbbbccccddddeeeefffffaaaabbbb'
  ) }
  let(:check_name) { ENV['PINGDOM_CHECK_NAME'] || '7fff' }
  let(:any_status) { /\"status\" => \"(?:unknown|up|paused)\"/m }
  let(:unpaused)   { /\"status\" => \"(?:unknown|up)\"/m }
  let(:paused)     { /\"status\" => \"paused\"/m }

  describe '#status' do
    it "should return a status for a check name" do
      VCR.use_cassette('status') do
        STDOUT.expects(:puts).with("Status for Pingdom '#{check_name}'")
        STDOUT.expects(:puts).with(regexp_matches(any_status))
        subject.status(check_name)
      end
    end
  end

  describe '#pause' do
    it "should be able to pause a check" do
      VCR.use_cassette('pause') do
         STDOUT.expects(:puts).with("Pausing Pingdom '#{check_name}'")
         subject.pause(check_name)
      end
      VCR.use_cassette('status_after_pause') do
        STDOUT.expects(:puts).with("Status for Pingdom '#{check_name}'")
        STDOUT.expects(:puts).with(regexp_matches(paused))
        subject.status(check_name)
      end
    end
  end

  describe '#unpause' do
    it "should be able to unpause a check" do
      VCR.use_cassette('unpause') do
         STDOUT.expects(:puts).with("Unpausing Pingdom '#{check_name}'")
         subject.unpause(check_name)
      end
      VCR.use_cassette('status_after_unpause') do
        STDOUT.expects(:puts).with("Status for Pingdom '#{check_name}'")
        STDOUT.expects(:puts).with(regexp_matches(unpaused))
        subject.status(check_name)
      end
    end
  end

end
