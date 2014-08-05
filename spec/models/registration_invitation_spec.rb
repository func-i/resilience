require 'rails_helper'

RSpec.describe RegistrationInvitation, :type => :model do
  context "associations" do
    it "belongs_to sender" do
      is_expected.to belong_to(:sender).class_name(User)
    end

    it "belongs_to recipient" do
      is_expected.to belong_to(:recipient).class_name(User)
    end
  end

  context "validations" do
    context "email address" do
      let(:invalid_email) { "@example.com"}
      let(:invitation) { FactoryGirl.build :registration_invitation }

      it "validate presence of recipient email" do
        is_expected.to validate_presence_of :recipient_email
      end

      it "validate for valid email address" do
        invitation.recipient_email = invalid_email
        invitation.valid?
        expect(invitation.errors.messages).to eq({recipient_email: [I18n::t('validators.email.invalid')]})
      end
    end
  end

  context "before filters" do
    let(:recipient_email) { Faker::Internet.email }
    subject { FactoryGirl.build :registration_invitation }

    describe "before_create" do
      it "generate invitation token" do
        expect{ subject.save }.to change(subject, :invitation_token)
      end
    end
  end

  describe "#expired?" do
    subject {FactoryGirl.create :registration_invitation}

    context "not expired" do
      it "is not expired" do
        expect(subject.expired?).to_not eq true
      end
    end

    context "expired" do
      subject {FactoryGirl.create :registration_invitation}

      it "is expired" do
        travel_to(subject.created_at + RegistrationInvitation::EXPIRE_PERIOD) do
          expect(subject.expired?).to eq true
        end
      end
    end

  end
end
