require "rails_helper"

RSpec.describe RegistrationInvitationMailer, :type => :mailer do
  let(:recipient_email) {Faker::Internet.email }
  let(:registration_invitation) {
    FactoryGirl.create :registration_invitation, recipient_email: recipient_email
  }

  describe "#invite" do
    it "deliver registration invitation email to the recipeint" do
      expect{
        email = RegistrationInvitationMailer.invite(registration_invitation)
        expect(email.to).to eq [recipient_email]
      }.to_not raise_error
    end
  end
end
