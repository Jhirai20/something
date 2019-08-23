require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get borrower" do
    get :borrower
    assert_response :success
  end

  test "should get lender" do
    get :lender
    assert_response :success
  end

end
