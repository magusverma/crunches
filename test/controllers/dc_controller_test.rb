require 'test_helper'

class DcControllerTest < ActionController::TestCase
  test "should get leaderboard" do
    get :leaderboard
    assert_response :success
  end

  test "should get rules" do
    get :rules
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get question" do
    get :question
    assert_response :success
  end

  test "should get theme" do
    get :theme
    assert_response :success
  end

end
