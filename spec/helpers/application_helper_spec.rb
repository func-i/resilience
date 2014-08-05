require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    let(:page_title_html) {
      "<div class=\"row page-title\"><div class=\"small-12 columns\"><h2>Lorem Ipsum</h2></div></div>"
    }

    it "should return an h2 tag with the given title" do
      helper.page_title("Lorem Ipsum")
      expect(helper.content_for(:page_title)).to eq page_title_html
    end
  end
end
