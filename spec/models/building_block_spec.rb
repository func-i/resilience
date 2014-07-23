require 'rails_helper'

RSpec.describe BuildingBlock, :type => :model do
  describe "associations" do
    it "belongs to owner" do
      is_expected.to belong_to(:owner).class_name(User)
    end

    it "have many files" do
      is_expected.to have_many(:attachments)
    end
  end

  context "validations" do
    it " validate presence of title" do
      is_expected.to validate_presence_of :title
    end
  end

  context "workflow states" do
    subject { FactoryGirl.create :building_block}

    it "initial state is draft" do
      expect(subject.workflow_state).to eq "draft"
    end
  end
end
