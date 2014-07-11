require "rails_helper"

feature 'User Password Reset' do

  background do
    @user = FactoryGirl.create(:user)
    visit root_path
  end

  scenario "emails user when requesting password reset" do
    click_link t('navigation.sign_in')
    click_link t('devise.passwords.forgotten_password')
    expect_any_instance_of(Devise::Mailer).to receive(:reset_password_instructions)

    within 'form' do
      fill_in "user[email]", with: @user.email
      click_button t('devise.passwords.send_password_instruction')
    end

    expect(page).to have_content(t('devise.passwords.send_instructions'))
  end

  scenario "user change his password" do
    token = @user.send_reset_password_instructions
    visit edit_user_password_url(id: @user.id, reset_password_token: token)


    expect(page.current_url).to eq edit_user_password_url(id: @user.id, reset_password_token: token)

    within 'form' do
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button t('simple_form.buttons.passwords.change')
    end

    expect(page).to have_content t('devise.passwords.updated')
    expect(page).to have_content t('navigation.sign_out')
  end
end
