require 'rails_helper'

RSpec.describe UserProfilesController, :type => :controller do

  subject { FactoryGirl.create :user }

  before do
    sign_in(subject)
  end

  describe "#edit" do
    it "render edit template" do
      get :edit, id: subject.id
      expect(assigns(:user)).to eq(subject)
      expect(response).to render_template 'edit'
    end
  end

  describe "#update" do
    before do
      patch :update, id: subject.id, user: params
      subject.reload
    end

    context "all required attributes are submited" do
      let(:params) {
        { name: 'New name',
          email: Faker::Internet.email,
          organization: Faker::Company.name
        }
      }

      it "update user profile" do
        expect(subject.name).to eq params[:name]
        expect(subject.email).to eq params[:email]
        expect(subject.organization).to eq params[:organization]
      end

      it "redirect to edit_user_profile_path" do
        expect(response).to redirect_to edit_user_profile_path(subject)
      end
    end

    context "required attribute is blank" do
      let(:params) { { name: ''} }

      it "do not update user profile" do
        expect(subject.email).to_not be_blank
      end

      it "redirect render 'edit' template" do
        expect(response).to render_template 'edit'
      end
    end

    describe "update password" do
      context "password and password_confirmation has match" do
        let (:params) {
          { password: 'newpassword',
            password_confirmation: 'newpassword'
          }
        }

        it "update user password" do
          expect(response).to redirect_to edit_user_profile_path
        end
      end

      context "password and password_confirmation dosen't match " do
        let (:params) {
          { password: 'newpassword',
            password_confirmation: 'wrongpassword'
          }
        }
        it "do not update user password when password dosent'\t match password_confirmation" do
          expect(response).to render_template 'edit'
        end
      end
    end
  end

end
