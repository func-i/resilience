require 'rails_helper'

RSpec.describe BaseDecorator, :type => :model do
  describe "#new" do
    let(:user) { FactoryGirl.create :user }
    subject { Manage::UserDecorator }

    it "returns user instanse" do
      expect(subject.new(user, nil)).to be_kind_of User
    end
  end

  describe "#decorated?" do
    let(:user) { FactoryGirl.create :user }
    subject { BaseDecorator.new(user, nil) }

    it "returns omma seprated string with humanized roles" do
      expect(subject.decorated?).to eq true
    end
  end
end
