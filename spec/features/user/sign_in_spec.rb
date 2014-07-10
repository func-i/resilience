require "rails_helper"

feature "User Sign in" do
  background do
    @user = FactoryGirl.create :user
  end

  scenario "Registerd users can sigin in" do

    visit '/users/sign_in'
    within "#new_user" do
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button t('navigation.sign_in')
    end

    expect(page).to have_content 'Signed in successfully.'
  end

end
