require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "successful user signup" do
    get '/signup'
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "rami_khafagi", email: "rami_khafagi@gamil.com", password: "rami1234" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "rami_khafagi", response.body
  end
end
