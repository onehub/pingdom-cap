require 'spec_helper'

describe PingdomCap::Client, '.new' do
  subject { PingdomCap::Client }
  it "should raise an error unless a key is specified" do
    lambda { subject.new(key: nil) }.should raise_error
  end
  it "should raise an error unless a url is specified" do
    lambda { subject.new(url: nil) }.should raise_error
  end
  it "should raise an error unless a username is specified" do
    lambda { subject.new(username: nil) }.should raise_error
  end
  it "should raise an error unless a password is specified" do
    lambda { subject.new(password: nil) }.should raise_error
  end
  it "should not raise an error when key, url, username, and password are specified" do
    lambda { subject.new(key: 'some_key', url: 'https://api.pingdom.com', username: 'john@7fff.com', password: '123456') }.should_not raise_error
  end
  it "should not raise an error when non-default options are missing" do
    lambda { subject.new(key: 'some_key', username: 'john@7fff.com', password: '123456') }.should_not raise_error
  end
  it "should create a connection during initialization" do
    client = subject.new(key: 'some_key', username: 'john@7fff.com', password: '123456')
    client.connection.should_not be_nil
  end
end


