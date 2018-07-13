require 'rails_helper'

RSpec.describe "Static Pages", type: :request do
  describe "Home Page" do
    it "should visit Root Page" do
      get home_path
      expect(response).to have_http_status(200)
    end
  end
end
