require 'spec_helper'

describe PingdomCap::Client do
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
end
