require 'rails_helper'

RSpec.describe User, :type => :model do
  context "factory" do
    it "have valid factory" do
      expect(FactoryGirl.create :user).to be_valid
    end
  end

  context "validations" do
    it " validate presence of email" do
      expect validate_presence_of :email
    end

    it " validate presence of name" do
      expect validate_presence_of :name
    end

    it " validate presence of organization" do
      expect validate_presence_of :organization
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
