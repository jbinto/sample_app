# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.org",
                            password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) } 
  it { should respond_to(:password_digest) } 
  it { should respond_to(:password) } 
  it { should respond_to(:password_confirmation) } 

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 } 
    it { should_not be_valid  } 
  end

  describe "when email format is invalid" do
    it "should be valid" do
      emails = %w(foo bax.com johhn@@bar.com)
      emails.each do |e|
        @user.email = e
        @user.should_not be_valid 
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      emails = %w(me@gmail.com foo-bar_baz@net-scape.com a+b@jp.cn)
      emails.each do |e|
        @user.email = e
        @user.should be_valid 
      end
    end
  end

  describe "when email addres is already taken - case insensitive" do
    before do
      user_same_email = @user.dup
      user_same_email.email = @user.email.upcase
      user_same_email.save
    end

    # note: `it` here refers to @user, not user_same_email
    it { should_not be_valid }
  end


  describe "email is saved to database in lowercase" do
    # Danger! I'm actually writing to the db. Is this a good idea?
    subject { @user.email }
    before do
      @user.email = "ABC@DEF.COM"
      @user.save
    end

    it { should == "abc@def.com" } 

    after do
      # Not sure if this is a good idea either... 'cleanup'?
      @user.destroy
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password does not match confirmation" do
    before { @user.password_confirmation = "confirm" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

end
