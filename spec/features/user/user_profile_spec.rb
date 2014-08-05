require "rails_helper"

feature "User Profile" do
  given(:user) { FactoryGirl.create :regular_user }

  background do
    signin(user.email, user.password)
    user.photo = File.open(user_photo_path)
    user.save
    visit edit_user_profile_path(user)
  end

  scenario "User can't update his profile wthout name" do
    within "form.user_profile" do
      fill_in "user[name]", with: ''
      click_button t('simple_form.buttons.user_profiles.edit.submit')
    end

    expect(page).to have_selector('div.alert')
    expect(page).to have_selector('div.user_name.error')
  end

  scenario "User can't update his profile wthout email" do
    within "form.user_profile" do
      fill_in "user[email]", with: ''
      click_button t('simple_form.buttons.user_profiles.edit.submit')
    end

    expect(page).to have_selector('div.alert')
    expect(page).to have_selector('div.user_email.error')
  end

  scenario "user can't update his profile wthout organization" do
    within "form.user_profile" do
      fill_in "user[organization]", with: ''
      click_button t('simple_form.buttons.user_profiles.edit.submit')
    end

    expect(page).to have_selector('div.alert')
    expect(page).to have_selector('div.user_organization.error')
  end

  given(:user_photo_path) {
    "#{Rails.root}/spec/fixtures/files/user_photo.jpg"
  }

  scenario "user attach profile photo" do
    within "form.user_profile" do
      attach_file('user[photo]', user_photo_path)
      click_button t('simple_form.buttons.user_profiles.edit.submit')
    end

    expect(page).to have_selector('img.user_profile_photo')
  end

  scenario "user delete his profile photo" do
    within "form.user_profile" do
      check 'user[remove_photo]'
      click_button t('simple_form.buttons.user_profiles.edit.submit')
    end

    expect(page).to_not have_selector('img.user_profile_photo')
  end
end
