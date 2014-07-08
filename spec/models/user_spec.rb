require 'rails_helper'

RSpec.describe User, :type => :model do
  context "factory" do
    it "have valid factory" do
      expect(FactoryGirl.create :user).to be_valid
    end
  end
end
