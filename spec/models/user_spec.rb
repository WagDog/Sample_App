# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe User do
  before {
    @user = User.new( name: "Example User", email: "user@example.com",password: "foobar", password_confirmation: "foobar")
  }
  subject { @user }
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:authenticate)}

  it {should be_valid}

  describe 'When name is not present' do
    before{@user.name = ''}
    it{should_not be_valid}
  end

  describe 'When name is too long' do
    before{@user.name = "a" * 51}
    it{should_not be_valid}
  end

  describe 'When email is not present' do
    before{@user.email = ''}
    it{should_not be_valid}
  end

  describe 'When password is not present' do
    before{@user.password = @user.password_confirmation = ''}
    it{should_not be_valid}
  end

  describe 'When password and confirmation do not match' do
    before{@user.password_confirmation = "mismatch"}
    it{should_not be_valid}
  end

  describe 'When the password confirmation is nil' do
    before{@user.password_confirmation = nil}
    it{should_not be_valid}
  end

  describe 'remember token' do
    before{@user.save}
    it{@user.remember_token.should_not be_blank}
  end

  describe "return value of authenticate method" do
    before {@user.save}
    let(:found_user){User.find_by_email(@user.email)}
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end
    describe "with invalid password" do
      let(:user_for_invalid_password){found_user.authenticate("invalid")}
      it{should_not == user_for_invalid_password}
      specify{expect(user_for_invalid_password).to be false} # be_false/be_true as in tutorial now deprecated to become 'be false' or 'be true'
                                                              # Can also use be_falsey apparently
    end
  end

  describe "When the password length is too short" do
    before{@user.password = @user.password_confirmation = "a" * 5}
    it{should be_invalid}
  end

  describe "When email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com] # %w creates a string array
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "When an email address is already taken" do
       before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end
      it{should_not be_valid}
  end
end