require 'rails_helper'

RSpec.describe Manage::BaseController, :type => :controller do
  controller do
    def index
      render nothing: true
    end
  end

  before do
    sign_in current_user
  end

  context "before actions" do
    describe "authorize_user!" do
      context "administrator" do
        let(:current_user) {FactoryGirl.create :admin }

        it "return true" do
          expect_any_instance_of(Manage::BaseController).to \
            receive(:authorize_user!).and_return(true)

          get :index
          expect(response.body).to be_blank
        end
      end

      context "regular user" do
        let(:current_user) {FactoryGirl.create :user }

        it "raise a error" do
          expect_any_instance_of(Manage::BaseController).to \
            receive(:authorize_user!).and_raise(Pundit::NotAuthorizedError)

          get :index
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
