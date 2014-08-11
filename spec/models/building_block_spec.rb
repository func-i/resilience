require 'rails_helper'

RSpec.describe BuildingBlock, :type => :model do
  describe "associations" do
    it "belongs to owner" do
      is_expected.to belong_to(:owner).class_name(User)
    end

    it "belongs to owner" do
      is_expected.to belong_to(:parent).class_name(BuildingBlock)
    end

    it "have many files" do
      is_expected.to have_many(:attachments)
    end

    it "have many files derivatives" do
      is_expected.to have_many(:derivatives).class_name(BuildingBlock)
    end
  end

  context "validations" do
    it " validate presence of title" do
      is_expected.to validate_presence_of :title
    end
  end

  context "initial workflow state" do
    subject { FactoryGirl.create :building_block}

    it "initial state is draft" do
      expect(subject.workflow_state).to eq "draft"
    end
  end

  describe "clone_with_new_owner" do
    context "clone from original" do
      let(:original_block) { FactoryGirl.create :building_block }
      let(:new_owner) { FactoryGirl.create :user }
      subject {original_block.clone_with_new_owner(new_owner)}

      it "derivative have new owner" do
        expect(subject.owner).to be new_owner
      end

      it "derivative belongs to original" do
        expect(subject.parent).to eq original_block
      end
    end

    context "clone from derivative" do
      let(:original_block) { FactoryGirl.create :building_block }
      let(:derivative) { original_block.clone_with_new_owner(new_owner) }
      let(:new_owner) { FactoryGirl.create :user }
      subject {derivative.clone_with_new_owner(new_owner)}

      it "derivative have new owner" do
        expect(subject.owner).to be new_owner
      end

      it "derivative belongs to original" do
        expect(subject.parent).to eq original_block
      end
    end
  end
end
