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

  before { @user = User.new(name: "Example User", email: "user@example.org") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) } 

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

end
