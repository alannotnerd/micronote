require 'rails_helper'

RSpec.describe "UserController", type: :request do
  describe "signup information" do
    it "shouldn\'t increase while pose invalid information" do
      before_post_count = User.count
      post users_path, user: {
        name: " ",
        email: "eo@ppo.com",
        password: "foo",
        password_comfirmation: "bar"
      }
      expect(User.count).to eq(before_post_count)
    end
    it "should create a new user" do
      expect{
	post users_path, user:{
	  name: "TestUser2",
	  email: "uuiiok@example.com",
	  password: "qwerasdf",
	  password_comfirmation: "qwerasdf"
	}
      }.to change{User.count}.by(1)
    end
  end 
end
