require "rails_helper"

feature 'User Sign out', :devise do
  background do
    @user = FactoryGirl.create :user
  end


  scenario 'Sigend in users can signs out' do
    signin(@user.email, @user.password)
    click_link 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page.current_path).to eq root_path
  end

end
