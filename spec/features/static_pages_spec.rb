require 'rails_helper'
require 'spec_helper'

# Described at location 6117. This tells the following test to use the Capybara object page as the
# default object for 'it'
# subject{page}

describe "Static Pages" do
  let(:base_title){"Ruby on Rails Tutorial Sample App"}

  describe "Home page" do
    before{visit root_path} # Described at location 6090. This means visit root_path before each test in this block

    it "should have the content Welcome to the Sample App" do
      # visit root_path
      # Deprecated code - page.should have_text('Sample App')
      expect(page).to have_selector('h1', 'Welcome to the Sample App')
    end

    it 'should have the correct base title' do
      # visit root_path
      expect(page).to have_title('Ruby on Rails Tutorial Sample App')
    end

    it "should not have a custom title" do
      # visit root_path
      expect(page).to_not have_title("| Home")
      #expect(page).to have_selector('title', text: "#base_title | Home")
    end
  end

  describe "Help page" do
    before{visit help_path} # Described at location 6090. This means visit help_path before each test in this block

    it "should have the content 'Help'" do
      # visit help_path
      # Deprecated code - page.should have_text('Sample App')
      expect(page).to have_selector('h1', 'Help')
    end

    it "should have the correct title" do
      # visit help_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About Us page" do
    before{visit about_path} # Described at location 6090. This means visit about_path before each test in this block

    it "should have the content 'About Us'" do
      # visit about_path
      # Deprecated code - page.should have_text('Sample App')
      expect(page).to have_selector('h1', 'About Us')
    end

    it "should have the correct title" do
      # visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
  end

  describe "Contact Us page" do
    before{visit contact_path} # Described at location 6090. This means visit contact_path before each test in this block

    it "should have the content 'Contact Us'" do
      # visit contact_path
      # Deprecated code - page.should have_text('Sample App')
      expect(page).to have_selector('h1', 'Contact Us')
    end

    it "should have the correct title" do
      # visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact Us")
    end
  end

  # Check the links
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title('Ruby on Rails Tutorial Sample App | About Us')
    click_link "Help"
    expect(page).to have_title('Ruby on Rails Tutorial Sample App | Help')
    click_link "Contact"
    expect(page).to have_title('Ruby on Rails Tutorial Sample App | Contact Us')
    click_link "Home"
    expect(page).to have_title('Ruby on Rails Tutorial Sample App')
    #click_link "Sign up now!"
    #expect(page).to have_title('Ruby on Rails Tutorial Sample App | Contact Us')
    #click_link "sample app"
    #page.should # fill in
  end
end
