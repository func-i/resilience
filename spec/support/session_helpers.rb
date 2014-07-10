module Features
  module SessionHelpers
    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button I18n::t('navigation.sign_in')
    end
  end
end
