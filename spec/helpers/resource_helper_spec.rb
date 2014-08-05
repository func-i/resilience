require "rails_helper"

RSpec.describe ResourceHelper, type: :helper do
  let!(:resource) { FactoryGirl.create :building_block }

  describe "#edit_action" do
    it "returns edit link" do
      expect(helper.edit_action resource).to match(/href=\"\/building_blocks\/#{resource.id}\/edit"/)
    end
  end

  describe "#destroy_action" do
    it "returns destroy_action link" do
      expect(helper.destroy_action resource).to match(/href=\"\/building_blocks\/#{resource.id}"/)
    end
  end

  describe "#show_action" do
    it "returns show_action link" do
      expect(helper.show_action(resource)).to match(/href=\"\/building_blocks\/#{resource.id}"/)
    end
  end
end
