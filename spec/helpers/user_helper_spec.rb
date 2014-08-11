require "rails_helper"

RSpec.describe UserHelper, type: :helper do
  context "devise" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "#devise_mapping" do
      it "returns user mapping" do
        expect(helper.devise_mapping).to eq Devise.mappings[:user]
      end
    end

    describe "#resource_name" do
      it "returns user" do
        expect(helper.resource_name).to eq :user
      end
    end

    describe "#resource_class" do
      it "returns user" do
        expect(helper.resource_class).to eq User
      end
    end
  end

  describe "#show_sign_in_out" do
    context "signed in user" do
      before do
        sign_in FactoryGirl.create :user
      end

      it "return sign out link" do
        expect(helper.show_sign_in_out).to match(/href=\"\/users\/sign_out\"/)
      end
    end

    context "signed out user" do
      it "return sign out link" do
        expect(helper.show_sign_in_out).to match(/href=\"\/users\/sign_in\"/)
      end
    end
  end
end
