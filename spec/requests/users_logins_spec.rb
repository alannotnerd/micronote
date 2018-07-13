require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "Login with invalid information" do
    it "renders login form" do
      get login_path
      expect(response).to render_template(:new)
    end

    it "renders login after post" do
      post login_path, session: { email: "", password: "" }
      expect(response).to render_template("sessions/new")
      expect(flash.empty?).to eq(false)
      get root_path
      expect(flash.empty?).to eq(true)
    end
  end

  describe "Login with valid information" do
    fixtures :users
    it "renders profile" do
      usp = users(:Man)
      get login_path
      post login_path, session: {email: usp.email, password: 'password'}
      expect(response).to redirect_to(usp)
      follow_redirect!
      expect(response).to render_template("users/show")
      should_not have_link("Log in", login_path)
      should have_link("Log out", logout_path)
      should have_link("Profile", user_path(usp))
    end
  end
end
