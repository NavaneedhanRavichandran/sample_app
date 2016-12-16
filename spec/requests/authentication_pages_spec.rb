require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "sign in page" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_content('Sign in') }
			it { should have_title('Ruby on Rails Tutorial Sample App | Sign in') }
			it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end

		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "Sign in"
			end

			it { should have_title('Ruby on Rails Tutorial Sample App | ' + user.name) }
			it { should have_link('Profile', href: user_path(user)) } # link for profile
			it { should have_link('Sign out', href: signout_path) } # link for signout
			it { should_not have_link('Sign in', href: signin_path) } # link for sign in

			describe "followed by signout" do
		        before { click_link "Sign out" }
		        it { should have_link('Sign in') }
		    end
		end
	end
end
