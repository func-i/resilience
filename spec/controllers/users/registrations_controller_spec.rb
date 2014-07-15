require 'rails_helper'

RSpec.describe Users::RegistrationsController, :type => :controller do
  let(:recipient_email) {Faker::Internet.email }
  let(:registration_invitation) {
    FactoryGirl.create :registration_invitation, recipient_email: recipient_email
  }

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "#new" do

    context "valid invitation token" do
      it "render template new" do
        get :new, invitation_token: registration_invitation.invitation_token
        expect(response).to render_template(:new)
      end
    end

    context "invaild invitation token" do
      it "redirect to root" do
        get :new, invitation_token: 'invitation_token'
        expect(response).to redirect_to root_path
      end
    end

    context "expired invitation" do
      it "redirect to root" do
        travel_to(registration_invitation.created_at + RegistrationInvitation::EXPIRE_PERIOD) do
          get :new, invitation_token: registration_invitation.invitation_token
          expect(response).to redirect_to root_path
        end
      end
    end

    context "accepted invitation" do
      let(:recipient) { FactoryGirl.build(:user, email: recipient_email) }

      before do
        registration_invitation.recipient_email = recipient_email
        registration_invitation.recipient = recipient
        registration_invitation.save
      end

      it "redirect to root" do
        get :new, invitation_token: registration_invitation.invitation_token
        expect(response).to redirect_to root_path
      end
    end

  end

  describe "#create" do
    let(:user_params) {
      {
        email: recipient_email,
        name: Faker::Name.name,
        organization: Faker::Company.name,
        password: 'password',
        password_confirmation: 'password'
      }
    }

    before do
      @invitation_token = registration_invitation.invitation_token
    end

    context "valid attributes" do
      it "sigin in user" do
        invitation_token = registration_invitation.invitation_token

        expect {
          post :create, user: user_params, invitation_token: @invitation_token
          expect(response).to redirect_to root_path
          expect(subject.user_signed_in?).to eq true
        }.to change { User.count }.by(1)
      end
    end

    context "missing required attribute" do
      before do
        user_params[:email] = ""
      end

      it "render template new" do
        expect {
            post :create, user: user_params, invitation_token: @invitation_token
            expect(response).to render_template :new
            expect(subject.user_signed_in?).to_not eq true
          }.to_not change { User.count }
      end
    end
  end

  context "not allowed actions" do
    let(:user) { FactoryGirl.create :user}

    before do
      sign_in user
    end

    describe "edit" do
      it "redirect to root" do
        get :edit, id: user.id
        expect(response).to redirect_to root_path
      end
    end

    describe "update" do
      it "redirect to root" do
        patch :update, id: user.id
        expect(response).to redirect_to root_path
      end
    end

    describe "destroy" do
      it "redirect to root" do
        delete :destroy, id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
