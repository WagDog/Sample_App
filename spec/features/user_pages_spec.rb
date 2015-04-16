require 'rails_helper'
require 'spec_helper'

describe "User Pages" do
  describe "Signup page" do
    before{visit signup_path} # Described at location 6251. This means visit signup_path before each test in this block

    it "should have the content Sign Up" do
      expect(page).to have_selector('h1', 'Sign Up')
    end

    it "should have the correct title" do
      # visit help_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Sign Up")
    end
  end

  describe "Show (Profile) Page" do
    let(:user){FactoryGirl.create(:user)}
    before{visit user_path(user)}

    it "should have the name in the H1 tag" do
      expect(page).to have_selector('h1', text: user.name)
    end

    it "should have the name in the title" do
      expect(page).to have_title(user.name)
    end
  end

  describe "Sign Up" do
    before{visit signup_path}
    let(:submit){"Create my account"}
    it "should not create a user with invalid information" do
      expect{click_button submit}.to_not change(User, :count)
    end

    describe "with valid information" do
      before do
        fill_in "Name",           with:"Example User"
        fill_in "Email",          with:"user@example.com"
        fill_in "Password",       with:"foobar"
        fill_in "Confirmation",   with:"foobar"
      end

      it "should create a user" do
        expect{click_button submit}.to change(User, :count).by(1)
      end
    end
  end
end