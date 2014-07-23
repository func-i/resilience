require 'rails_helper'

RSpec.describe Role, :type => :model do

  describe "::humanized" do
    subject { Role }

    before do
      FactoryGirl.create :regular_role
    end

    it "returns array of arrays with humanized role names and role ids" do
      role = Role.first
      expect(subject.humanized).to eq [[role.name.humanize, role.id]]
    end
  end

end
