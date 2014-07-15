require "rails_helper"

feature "Sign up", :devise do
  given(:recipient_email) { Faker::Internet.email }
  given(:registration_invitation) {
    FactoryGirl.create :registration_invitation, recipient_email: recipient_email
  }
  given(:email) { RegistrationInvitationMailer.invite(registration_invitation) }

  background do
    email.deliver
    click_invitation_link registration_invitation
  end

  scenario 'Invited person signed up from received invitation' do
    fill_sign_up_form ({name: Faker::Name.name,
      email: registration_invitation.recipient_email,
      organization: Faker::Company.name,
      password: 'password',
      password_confirmation: 'password'})

    expect(page).to have_content t('devise.registrations.signed_up')
  end

  scenario 'Sign up is unsuccessful when email field is not valid email' do
    fill_sign_up_form ({name: Faker::Name.name,
      email: 'invalid',
      organization: Faker::Company.name,
      password: 'password',
      password_confirmation: 'password'})

    expect(page).to have_content 'Please review the problems below:'
    expect(page.has_selector?('div.user_email.error')).to eq true
  end

  scenario 'Sign up is unsuccessful when name field is empty' do
    fill_sign_up_form ({name: '',
      email: registration_invitation.recipient_email,
      organization: Faker::Company.name,
      password: 'password',
      password_confirmation: 'password'})

    expect(page).to have_content 'Please review the problems below:'
    expect(page.has_selector?('div.user_name.error')).to eq true
  end

  scenario 'Sign up is unsuccessful when name organization is empty' do
    fill_sign_up_form ({name: Faker::Name.name,
      email: registration_invitation.recipient_email,
      organization: '',
      password: 'password',
      password_confirmation: 'password'})

    expect(page).to have_content 'Please review the problems below:'
    expect(page.has_selector?('div.user_organization.error')).to eq true
  end

  def click_invitation_link registration_invitation
    visit(parse_email_for_link(email, /sign_up/))
    expect(page.current_url).to \
      eq(new_user_registration_url(invitation_token: registration_invitation.invitation_token))
  end

  def fill_sign_up_form fields = {}
    within 'form' do
      fill_in "user[email]", with: fields[:email]
      fill_in "user[name]", with: fields[:name]
      fill_in "user[organization]", with: fields[:organization]
      fill_in "user[password]", with: fields[:password]
      fill_in "user[password_confirmation]", with: fields[:password]

      click_button t('simple_form.buttons.users.registrations.new.submit')
    end
  end
end


