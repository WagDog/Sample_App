require 'rails_helper'
require 'spec_helper'

describe "User Pages" do
  describe "Signup page" do
    before{visit signup_path} # Described at location 6251. This means visit signup_path before each test in this block

    it("should have the content Sign Up") { expect(page).to have_selector('h1', 'Sign Up') }
    it("should have the correct title") { expect(page).to have_title("Ruby on Rails Tutorial Sample App | Sign Up") }
  end

  describe "Show (Profile) Page" do
    let(:user){FactoryGirl.create(:user)}
    before{visit user_path(user)}

    it("should have the name in the H1 tag") { expect(page).to have_selector('h1', text: user.name) }
    it("should have the name in the title") { expect(page).to have_title(user.name) }
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

      it("should create a user") { expect { click_button submit }.to change(User, :count).by(1) }
    end
  end

  describe "edit" do
    let(:user){FactoryGirl.create(:user)}
    before {visit edit_user_path(user)}
    describe "page" do
      it("should have the correct H1 tag. Comment out the before_filter lines in the users_controller if this fails!!") { expect(page).to have_selector('h1', text: "Update your profile") }
      it("should have the correct title") { expect(page).to have_title("Edit user") }
      it("should have the correct Gravatar link") { expect(page).to have_link("Change", href: "http://gravatar.com/emails") }
    end
    describe "with valid information" do
      let(:new_name){"new_name"}
      let(:new_email){"new_email@example.com"}
      before do
        fill_in "Name",           with: new_name
        fill_in "Email",          with: new_email
        fill_in "Password",       with: user.password
        fill_in "Confirmation",   with: user.password
        click_button "Save changes"
      end

      it("should have the correct title.") { expect(page).to have_title(new_name) }
      it("should have the correct alert message") { expect(page).to have_selector("div.alert.alert-success") }
      it("should have the sign out link") { expect(page).to have_link("Sign out", href: signout_path) }
      specify{user.reload.name == new_name}
      specify{user.reload.email == new_email}
    end
    describe "with invalid information" do
      before {click_button "Save changes"}
      it("should show an error message") { expect(page).to have_content("error") }
    end
  end
end