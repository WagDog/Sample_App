require 'rails_helper'
require 'spec_helper'


# Rules for Authentication, which is where we can identify the user
describe 'Authentication' do
  describe 'Signin page' do
    before{visit signin_path} # Described at location 9531. This means visit signin_path before each test in this block

    describe 'with invalid information' do
      before{click_button 'Sign in'}
        it('should have an error message') { expect(page).to have_selector('div.alert.alert-error', text: 'Invalid') }
        it('should have the correct title') { expect(page).to have_title('Ruby on Rails Tutorial Sample App | Sign in') }

        describe 'after visiting another page' do
          before{click_link 'Home'}
          it('should not show the error message') { expect(page).to_not have_selector('div.alert.alert-error', text: 'Invalid') }
        end
    end

    describe 'with valid information' do
      let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it('should have the correct title') { expect(page).to have_title(user.name) }
      it('should have the Profile link') { expect(page).to have_link('Profile', href: user_path(user)) }
      it('should have the Settings link') { expect(page).to have_link('Settings', href: edit_user_path(user)) }
      it('should have the Sign out link') { expect(page).to have_link('Sign out', href: signout_path) }
      it('should not have the Sign in link') { expect(page).to_not have_link('Sign in', href: signin_path) }

    end
  end

  # Rules for Authorisation, where we can make sure users can only do what they are supposed to
  # NOTE - Capybara, which is used for most of the testing syntax such as 'visit', 'page' etc
  # cannot POST or PUT http requests.
  before{delete_path(signout_path)}
  describe 'Authorisation' do
    describe 'for non-signed-in users' do
      let(:user) {FactoryGirl.create(:user)}
      describe 'in the users controller' do
        describe 'visiting the edit page' do
          before{visit edit_user_path(user)}
          it('should have the title Sign in'){ expect(page).to have_title('Sign in') }
        end

        describe 'visiting the wrong users#edit page' do
          let(:wrong_user){FactoryGirl.create(:user, email:'wrong@example.com')}
          before{visit edit_user_path(wrong_user)}
          it('should not have the title Sign in'){expect(page).to_not have_title('Sign in')}
        end
        #describe 'submitting to the update action' do    # Cannot do this test with capybara, as does not support HTTP verbs such as PUT
        #  before{put_path user_path(user)}
        #  specify{expect(response).to redirect_to(signin_path)}
        #end
      end
    end
  end
end

# Define a function to overcome Capybara's inability to process some HTTP verbs
def put_path(somepath)
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :put, somepath
  Capybara.current_driver = current_driver
end
def delete_path(somepath)
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, somepath
  Capybara.current_driver = current_driver
end
