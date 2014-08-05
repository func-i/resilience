require 'rails_helper'

RSpec.describe Manage::UserDecorator, :type => :model do

  describe "#roles" do
    let(:user) { FactoryGirl.create :user }
    subject { Manage::UserDecorator.new(user, nil) }

    before do
      user.add_role "administrator"
    end

    it "returns omma seprated string with humanized roles" do
      expect(subject.roles).to eq "Regular, Administrator"
    end
  end

  describe "#photo" do
    FakeViewContext = Class.new { include ActionView::Helpers }

    let(:user) { FactoryGirl.create :user }
    let(:image) {
      File.new "#{Rails.root}/spec/fixtures/files/user_photo.jpg"
    }
    let(:view_context) { FakeViewContext.new }

    subject { Manage::UserDecorator.new(user, view_context) }

    before do
      user.photo = image
      user.save
    end


    it "return image tag with user photo" do
      expect(subject.photo).to match(/img/)
    end
  end
end
