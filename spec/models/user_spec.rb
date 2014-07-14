require 'rails_helper'

RSpec.describe User, :type => :model do
  context "factory" do
    it "have valid factory" do
      expect(FactoryGirl.create :user).to be_valid
    end
  end

  context "assocaitions" do
    it "have many registration invitations as inviter" do
      is_expected.to have_many(:registration_invitations)
    end

    it "have one registration invitation as recipient" do
      is_expected.to have_one(:registration_invitation)
    end
  end

  context "validations" do
    it " validate presence of email" do
      is_expected.to validate_presence_of :email
    end

    it " validate presence of name" do
      is_expected.to validate_presence_of :name
    end

    it " validate presence of organization" do
      is_expected.to validate_presence_of :organization
    end
  end

  describe ".photo" do
    let(:image) {
      File.new "#{Rails.root}/spec/fixtures/files/user_photo.jpg"
    }

    subject { FactoryGirl.create :user}

    before do
      subject.photo = image
      subject.save
    end

    context "assign photo" do
      it "have photo_name" do
        expect(subject.photo_name).to_not be_blank
      end

      it "have photo_uid" do
        expect(subject.photo_uid).to_not be_blank
      end
    end

    context "thumb" do
      it "have thumb with default size" do
        expect(subject.thumb.width).to eq 90
      end
    end
  end
end
