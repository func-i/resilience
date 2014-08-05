require 'rails_helper'

RSpec.describe Manage::UserCollectionDecorator, :type => :model do
  describe "#new" do
    let(:users) {
      2.times { FactoryGirl.create :user }
      User.all
    }
    subject { Manage::UserCollectionDecorator }

    it "returns User ActiveRecord relation" do
      expect(subject.new(users, nil)).to be_kind_of ActiveRecord::Relation
    end

    it "decorate collection items" do
      subject.new(users, nil).each do |user|
        expect(user).to be_kind_of User
        expect(user.decorated?).to eq true
      end
    end
  end
end
