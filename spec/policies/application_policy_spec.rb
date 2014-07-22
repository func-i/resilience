require 'rails_helper'

describe ApplicationPolicy do
  let(:current_user) { FactoryGirl.create :user }
  let(:record) { FactoryGirl.create :user }
  subject { ApplicationPolicy.new(current_user, record) }

  describe "#new" do
    it "have user instance variable" do
      expect(subject.user).to eq current_user
    end

    it "have record instance variable" do
      expect(subject.record).to eq record
    end
  end
end
