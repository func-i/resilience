require 'rails_helper'

describe Manage::UserPolicy do
  let(:current_user) { FactoryGirl.create :user }
  let(:record) { FactoryGirl.create :user }
  subject { Manage::UserPolicy.new(current_user, record) }

  describe "#update_params" do
    before do
      FactoryGirl.create :administrator_role
      FactoryGirl.create :regular_role
    end

    let(:params) {
      ActionController::Parameters.new(user:
        { role_ids: [Role.first.id, Role.last.id], name: 'User name' })
    }

    it "cleans user params" do
      expect(subject.update_params(params)).to_not have_key(:name)
    end
  end
end
