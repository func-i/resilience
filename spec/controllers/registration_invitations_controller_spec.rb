require 'rails_helper'

RSpec.describe RegistrationInvitationsController, :type => :controller do
  let(:current_user) { FactoryGirl.create :user }

  before do
    sign_in current_user
  end

  describe "#new - GET: /registration_invitations/new" do
    it "render template new" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:registration_invitation)).to_not be_blank
    end
  end

  describe "#create - POST: /registration_invitations" do
    let(:params) { {recipient_email: Faker::Internet.email } }

    it "redirect to action new" do
      expect{
        expect_any_instance_of(RegistrationInvitationMailer).to receive(:invite)

        post :create, registration_invitation: params
        expect(assigns(:registration_invitation)).to_not be_blank
        expect(response).to redirect_to(new_registration_invitation_path)
      }.to change {
        RegistrationInvitation.count
      }.by(1)

    end
  end
end
