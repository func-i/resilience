require "rails_helper"

feature 'User Password Reset' do

  background do
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link t('navigation.sign_in')
  end

  scenario "emails user when requesting password reset" do
    click_link t('devise.passwords.forgoten_password')
    expect_any_instance_of(Devise::Mailer).to receive(:reset_password_instructions)

    within 'form' do
      fill_in "user[email]", with: @user.email
      click_button t('devise.passwords.send_password_instruction')
    end

    expect(page).to have_content(t('devise.passwords.send_instructions'))
  end
end
