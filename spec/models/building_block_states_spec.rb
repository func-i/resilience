require 'rails_helper'

RSpec.describe BuildingBlock, :type => :model do
  context "workflow states" do
    subject { FactoryGirl.create :building_block}

    describe "draft -> awaiting_review" do
      it "transition form 'draft' to 'awaiting_review'" do
        expect{subject.submit!}.to \
          change(subject, :workflow_state).from("draft").to('awaiting_review')
      end
    end

    describe "awaiting_review -> under_review" do
      before do
        subject.submit!
      end

      it "transition form 'awaiting_review' to 'under_review'" do
        expect{subject.reviewing!}.to \
          change(subject, :workflow_state).from("awaiting_review").to('under_review')
      end
    end

    describe "under_review -> accepted" do
      before do
        subject.submit!
        subject.reviewing!
      end

      it "transition form 'under_review' to 'accepted'" do
        expect{subject.accept!}.to \
          change(subject, :workflow_state).from("under_review").to('accepted')
      end
    end

    describe "under_review -> rejected" do
      before do
        subject.submit!
        subject.reviewing!
      end

      it "transition form 'under_review' to 'rejected'" do
        expect{subject.reject!}.to \
          change(subject, :workflow_state).from("under_review").to('rejected')
      end
    end
  end
end
