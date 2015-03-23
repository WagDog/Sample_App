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
end