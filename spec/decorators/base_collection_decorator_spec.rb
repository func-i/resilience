require 'rails_helper'

RSpec.describe BaseCollectionDecorator, :type => :model do
  let(:users) {
    2.times { FactoryGirl.create :user }
    User.page(1).per(1)
  }

  subject { BaseCollectionDecorator }

  describe "#new" do
    it "returns User ActiveRecord relation" do
      expect(subject.new(users, nil)).to be_kind_of ActiveRecord::Relation
    end
  end

  describe "#is_a?" do
    it "to be ActiveRecord::Relation" do
      expect(subject.new(users, nil).is_a?(ActiveRecord::Relation)).to eq(true)
    end
  end

  describe "current_page" do
    it "respond to current_page" do
      expect_any_instance_of(BaseCollectionDecorator).to receive(:current_page).and_return(1)
      subject.new(users, nil).current_page
    end
  end

  describe "total_pages" do
    it "respond to total_pages" do
      expect_any_instance_of(BaseCollectionDecorator).to receive(:total_pages).and_return(2)
      subject.new(users, nil).total_pages
    end
  end

  describe "limit_value" do
    it "respond to limit_value" do
      expect_any_instance_of(BaseCollectionDecorator).to receive(:limit_value).and_return(1)
      subject.new(users, nil).limit_value
    end
  end

  describe "total_count" do
    it "respond to total_count" do
      expect_any_instance_of(BaseCollectionDecorator).to receive(:total_count).and_return(2)
      subject.new(users, nil).total_count
    end
  end
end
