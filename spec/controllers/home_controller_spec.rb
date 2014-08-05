require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "GET: /home/index" do
    it "render index view" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
