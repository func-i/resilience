require 'rails_helper'

RSpec.describe BuildingBlocksController, :type => :controller do
  let(:current_user) { FactoryGirl.create :user }

  describe "GET /building_blocks" do
    before do
      2.times { FactoryGirl.create :building_block }
    end

    it "render 'index' template" do
      get :index
      expect(assigns(:building_blocks)).to eq BuildingBlock.all
      expect(response).to render_template :index
    end
  end

  describe "GET /building_blocks/:id" do
    let(:building_block) { FactoryGirl.create :building_block }

    it "render 'show' template" do
      get :show, id: building_block.id
      expect(assigns(:building_block)).to eq building_block
      expect(response).to render_template :show
    end
  end

  describe "GET /building_blocks/new" do
    before do
      sign_in current_user
    end

    it "render 'new' template" do
      get :new
      expect(assigns(:building_block)).to be_new_record
      expect(response).to render_template :new
    end
  end

  describe "POST /building_blocks" do
    let(:params) { { title: Faker::Company.name } }

    before do
      sign_in current_user
    end

    it "redirect to show action" do
      expect {
        post :create, building_block: params
        expect(response).to \
          redirect_to building_block_path(assigns(:building_block).id)
      }.to change(BuildingBlock, :count).by(1)
    end
  end

  describe "GET /building_blocks/:id/edit" do
    before do
      sign_in current_user
    end

    context "current_user is building block owner" do
      let!(:building_block) { FactoryGirl.create :building_block, owner: current_user }

      it "render 'edit' template" do
        get :edit, id: building_block.id
        expect(assigns(:building_block)).to_not be_new_record
        expect(response).to render_template :edit
      end
    end


    context "logged in user is not the building block owner" do
      let!(:building_block) {
        FactoryGirl.create :building_block,
          owner: FactoryGirl.create(:user)
      }

      it "clone the original and render 'new' template" do
        get :edit, id: building_block.id
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH /building_block/id:" do
    let(:building_block) {
      FactoryGirl.create :building_block, owner: current_user
    }
    let(:new_title) { Faker::Company.name }
    let(:params) { {title: new_title} }

    before do
      sign_in current_user
    end

    it "redirect to 'show' action" do
      expect {
        patch :update, id: building_block.id, building_block: params
        expect(response).to redirect_to building_block_path(building_block)
        building_block.reload
      }.to change(building_block, :title).to(new_title)
    end
  end

  describe "DELETE /building_block/:id" do
    let(:building_block) { FactoryGirl.create :building_block, owner: current_user }

    before do
      sign_in current_user
    end

    it "redirect to building_blocks 'index'" do
      delete :destroy, id: building_block.id
      expect(assigns(:building_block).persisted?).to eq false
      expect(response).to redirect_to building_blocks_path
    end
  end

end
