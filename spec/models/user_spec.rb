require 'active_record'
require 'sorcery'
require 'spec_helper'
require_relative '../../app/models/user'

describe User do
  context "validations" do
    before do
      subject.save
    end
    it "should not save if invalid" do
      subject.save.should be_false
    end
    it "should require a username" do
      subject.errors[:username].should eq ["can't be blank"]
    end
    it "should require a password" do
      subject.errors[:password].should eq ["can't be blank"]
    end
    it "should require an email address" do
      subject.errors[:email].should eq ["can't be blank"]
    end
  end
end

