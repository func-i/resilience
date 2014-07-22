require 'rails_helper'

RSpec.describe Manage::UsersController, :type => :controller do

  before do
    sign_in current_user
  end

  context "CRUD" do
    let(:user) { FactoryGirl.create :user }
    let(:current_user) { FactoryGirl.create :admin }

    describe "index - GET /manage/users" do
      it "render index template" do
        get :index
        expect(response).to render_template 'index'
        expect(assigns(:users).class).to eq User::ActiveRecord_Relation
      end
    end

    describe "show - GET /manage/users/:id" do
      it "render index template" do
        get :show, id: user.id
        expect(response).to render_template 'show'
        expect(assigns(:user)).to eq user
      end
    end

    describe "new - GET /manage/users/new" do
      it "raise a error" do
        expect { get :new }.to raise_error
      end
    end

    describe "edit - GET /manage/users/:id/edit" do
      it "render new template" do
        get :edit, id: user.id
        expect(response).to render_template 'edit'
        expect(assigns(:user)).to eq user
      end
    end

    describe "update - PATCH /manage/users/:id" do
      let(:user_params) {
        {role_ids: [FactoryGirl.create(:administrator_role).id,
          FactoryGirl.create(:regular_role).id]
        }
      }

      it "redirect to show action" do
        expect {
          patch :update, id: user.id, user: user_params
          expect(assigns(:user).roles.count).to eq(2)
          expect(response).to redirect_to manage_user_path(user)
        }
      end
    end

    describe "destroy - DELETE /manage/users/:id" do
      it "redirect to show action" do
        delete :destroy, id: user.id
        expect(response).to redirect_to manage_users_path
      end
    end
  end
end
