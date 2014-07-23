require "rails_helper"

RSpec.describe Manage::SortableHelper, type: :helper do
  describe "#sort_by_link" do
    helper do
      def sort_column
          'user'
      end

      def params
        {controller: 'manage/users', action: 'index'}
      end
    end

    let(:attributes) { ['users', 'name', 'Name'] }

    it "generate sort link" do
      expect(helper.sort_by_link(*attributes)).to match(/direction=asc&amp;sort=users.name/)
    end
  end
end

