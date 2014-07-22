require 'rails_helper'

describe Manage::UserSearch do
  let(:first_user_email) { 'first_user@example.com' }
  let(:first_user_name)  { 'John Doe' }
  let(:first_user_organization)  { 'First user organization' }

  before do
    FactoryGirl.create :user,
      email: first_user_email,
      name: first_user_name,
      organization: first_user_organization
    FactoryGirl.create :user
  end

  describe "searches" do
    subject { Manage::UserSearch }

    describe "#search_email_contains" do
      it "results contains users matched by email" do
        expect(
          subject.new(email_contains: first_user_email[0..4]).results.to_a
        ).to eq User.where(email: first_user_email).to_a
      end
    end

    describe "#search_name_contains" do
      it "results contains users matched by name" do
        expect(
          subject.new(name_contains: first_user_name[0..4]).results.to_a
        ).to eq User.where(name: first_user_name).to_a
      end
    end

    describe "#search_organization_contatins" do
      it "results contains users matched by organization" do
        expect(
          subject.new(organization_contatins: first_user_organization[0..4]).results.to_a
        ).to eq User.where(organization: first_user_organization).to_a
      end
    end

    describe "#search_has_role" do
      let(:administrator_role) { FactoryGirl.create :administrator_role}

      before do
        FactoryGirl.create :user
        FactoryGirl.create :user, roles: [administrator_role]
      end

      it "results contains users with specific role" do
        expect(
          subject.new(has_role: administrator_role.id).results.to_a
        ).to eq User.with_role(:administrator).to_a
      end
    end
  end
end
