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

  describe "#user_roles" do
    context "loged in user" do
      it "returns array with loged in user roles names" do
        expect(subject.user_roles).to eq current_user.roles.pluck(:name)
      end
    end

    context "not loged in user" do
      let(:current_user) { nil }
      it "raise a error" do
        expect{ subject.user_roles }.to raise_error  Pundit::NotAuthorizedError
      end
    end
  end
end
